//
//  PhotoButton.swift
//  BiRTH
//
//  Created by 이소현 on 11/27/24.
//

import SwiftUI
import PhotosUI

struct PhotoButton: View {
    @State var showingPhotoPicker = false
    @Binding var selectedPhotos: [PastedImage]
    
    var body: some View {
        Button {
            showingPhotoPicker.toggle()
            print("PhotoButton")
        } label: {
            FeatureCircle(colorHex: "FFF100", featureImgName: "photo", featureName: "사진")
        }
        .sheet(isPresented: $showingPhotoPicker) {
            PastedPhotoPicker(pastedImages: $selectedPhotos)
        }
        
    }
}

struct PastedPhotoPicker: UIViewControllerRepresentable {
    @Binding var pastedImages: [PastedImage]

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
        let parent: PastedPhotoPicker

        init(_ parent: PastedPhotoPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                        if let image = object as? UIImage {
                            DispatchQueue.main.async {
                                // 랜덤 위치 및 크기로 PastedImage 생성
                                let aspectRatio = image.size.height / image.size.width
                                let randomOffset = CGSize(width: CGFloat.random(in: -30...30), height: CGFloat.random(in: -30...30))
                                let pastedImage = PastedImage(
                                    imageWidth: 150,
                                    imageHeight: 150 * aspectRatio,
                                    imagePosition: CGPoint(
                                        x: UIScreen.main.bounds.width / 2 + randomOffset.width,
                                        y: UIScreen.main.bounds.height / 2 + randomOffset.height
                                    ),
                                    angle: .zero,
                                    angleSum: 0,
                                    pastedImage: image
                                )
                                self.parent.pastedImages.append(pastedImage)
                            }
                        }
                    }
                }
            }
        }
    }
}


//#Preview {
//    PhotoButton()
//}
