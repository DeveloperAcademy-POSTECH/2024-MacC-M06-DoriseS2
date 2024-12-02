//
//  AppCodeNotes.swift
//  BiRTH
//
//  Created by 이소현 on 12/3/24.
//

import Foundation

// MARK: - CollageByMyselfView
// isCustomSheet
//CustomSheet(
//    image: $pastedImages[selectedIndex].pastedImage,
//    sheetHeight: $sheetHeight,
//    isCustomSheet: $isCustomSheet,
//    pastedImages: $pastedImages,
//    selectedImageID: $selectedImageID
//)
//.transition(.move(edge: .bottom))
//.animation(.easeInOut(duration: 0.5), value: isCustomSheet)


// MARK: - CustomSheet
//if isCustomSheet {
//    EmptyView()
//        .opacity(0)
//        .ignoresSafeArea()
//}
//
//ZStack(alignment: .topTrailing) {
//
//    ScrollView(.horizontal) {
//        LazyHGrid(rows: rows, spacing: 24) {
//
//            RemoveBackgroundButton(image: $image)
//            DeleteButton(pastedImages: $pastedImages, selectedImageID: $selectedImageID)
//
//        }
//        .padding()
//        Spacer()
//    }
//    
//    HStack {
//        Spacer()
//        Button {
//            withAnimation(.easeInOut(duration: 0.5)) {
//                isCustomSheet = false
//            }
//        } label: {
//            Image(systemName: "xmark.circle")
//                .foregroundStyle(.black)
//                .font(.system(size: 24))
//        }
//        .padding(.vertical)
//        .padding(.horizontal, 14)
//    }
//}
//.frame(maxWidth: .infinity)
//.frame(maxHeight: sheetHeight)
//.background(.white)
//.cornerRadius(16, corners: .topLeft)
//.cornerRadius(16, corners: .topRight)
//.transition(.move(edge: .bottom))
//
//}
//.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
//.ignoresSafeArea()
//.animation(.easeInOut(duration: 0.5), value: isCustomSheet)


// Second
//CustomSheet(
//    selectedImage: $pastedImages[selectedIndex].pastedImage,
//    pastedImages: $pastedImages,
//    selectedImageID: $selectedImageID
//)
//.presentationBackground(.black)
//.interactiveDismissDisabled()
//.presentationDetents([.fraction(0.2)])
//.presentationCornerRadius(16)
//.presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.2)))



// MARK: - SendAndShareButton

//    @MainActor
//    func captureView(
//        of view: some View,
//        scale: CGFloat = 1.0,
//        size: CGSize? = nil,
//        completion: @escaping (UIImage?) -> Void
//    ) {
//        let renderer = ImageRenderer(content: view)
//        renderer.scale = scale
//
//        if let size = size {
//            renderer.proposedSize = .init(size)
//        }
//
//        completion(renderer.uiImage)
//    }
//
//    @MainActor
//    func captureAndSaveView(
//        of view: some View,
//        scale: CGFloat = 1.0,
//        size: CGSize? = nil
//    ) {
//        // 캡처 수행
//        let renderer = ImageRenderer(content: view)
//        renderer.scale = scale
//
//        if let size = size {
//            renderer.proposedSize = .init(size)
//        }
//
//        guard let capturedImage = renderer.uiImage else {
//            print("Failed to capture image.")
//            return
//        }
//
//        // 이미지 저장
//        UIImageWriteToSavedPhotosAlbum(capturedImage, nil, nil, nil)
//
//        // 사진 권한 요청 및 상태에 따른 처리
//        PHPhotoLibrary.requestAuthorization { status in
//            DispatchQueue.main.async {
//                switch status {
//                case .authorized:
//                    print("Image successfully saved!")
//                case .denied, .restricted, .notDetermined:
//                    print("Permission denied or not determined.")
//                case .limited:
//                    print("Image successfully saved with limited access.")
//                @unknown default:
//                    print("Unknown authorization status.")
//                }
//            }
//        }
//    }
