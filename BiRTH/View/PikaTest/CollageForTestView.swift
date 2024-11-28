//
//  CollageForTestView.swift
//  BiRTH
//
//  Created by Hajin on 11/22/24.
//

import SwiftUI
import CoreData
import PhotosUI

struct PhotoPickerAndListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BPhotoForCollage.posX, ascending: true)],
        animation: .default
    ) private var photos: FetchedResults<BPhotoForCollage>

    @State private var selectedPhotos: [UIImage] = []
    @State private var showPhotoPicker = false

    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                            HStack {
                                ForEach(selectedPhotos, id: \.self) { image in
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .clipped()
                                        .cornerRadius(10)
                                }
                            }
                        }

            // PhotoPicker 버튼
            Button(action: {
                showPhotoPicker = true
            }) {
                Text("Add Photos")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $showPhotoPicker) {
                PhotoPicker(selectedImages: $selectedPhotos)
            }

            // 저장 버튼
            Button(action: {
                savePhotosToCoreData()
            }) {
                Text("Save Photos")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            // 저장된 사진 리스트
            List {
                ForEach(photos) { photo in
                    if let imageData = Data(base64Encoded: photo.image ?? ""),
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                    } else {
                        Text("Invalid Image")
                    }
                }
            }
        }
        .padding()
    }

    // Core Data에 저장
    private func savePhotosToCoreData() {
        for image in selectedPhotos {
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                // Base64로 이미지 데이터 변환
                let base64Image = imageData.base64EncodedString()

                // Core Data 객체 생성

                let newPhoto = BPhotoForCollage(context: viewContext)
                newPhoto.id = UUID()
                newPhoto.image = base64Image
                newPhoto.posX = 0
                newPhoto.posY = 0
                newPhoto.scaleX = 1
                newPhoto.scaleY = 1
                newPhoto.rotation = 0
               
            }
        }

        // 데이터를 저장하고 뷰 업데이트
        do {
            try viewContext.save()
            selectedPhotos.removeAll() // 선택된 사진 초기화
            print("Data successfully saved.")
        } catch {
            print("Failed to save data: \(error)")
        }
    }
}

// PhotoPicker 구현
struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImages: [UIImage]

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0 // 여러 장 선택 가능
        configuration.filter = .images // 이미지만 표시
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker

        init(_ parent: PhotoPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                        if let image = object as? UIImage {
                            DispatchQueue.main.async {
                                self.parent.selectedImages.append(image)
                            }
                        }
                    }
                }
            }
        }
    }
}




#Preview {
    PhotoPickerAndListView()
}
