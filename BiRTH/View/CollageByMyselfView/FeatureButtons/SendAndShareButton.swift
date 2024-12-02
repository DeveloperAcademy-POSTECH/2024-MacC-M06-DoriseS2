//
//  SendAndShareButton.swift
//  BiRTH
//
//  Created by 이소현 on 12/2/24.
//

import SwiftUI
import Photos

struct SendAndShareButton: View {
    @State private var showingAlert: Bool = false
    
    var body: some View {
        Button {
            showingAlert = true
            screenShot()
            print("ㅎㅇ")
        } label: {
            FeatureCircle(colorHex: "8174A0", featureImgName: "paperplane", featureName: "사진공유")
        }
        .alert(isPresented: $showingAlert) {
            let firstButton = Alert.Button.cancel(Text("완료")) {
                
                print("secondary button pressed")
            }
            let secondButton = Alert.Button.default(Text("공유하기")) {
                share()
            }
            
            return Alert(title: Text("저장하기"),
                         message: Text("이미지를 저장합니다."),
                         primaryButton: firstButton, secondaryButton: secondButton)
        }
    }
}

extension SendAndShareButton {
    /// 이미지 저장
    func screenShot() {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows
            .first else {
            print("Failed to fetch the key window.")
            return
        }
        
        let screenshot = window.screenShot // 전체 창 캡처
        UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
        
        // 사진 권한 요청 및 상태에 따른 처리
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    self.showingAlert = true
                case .denied, .restricted, .notDetermined:
                    break
                case .limited:
                    showingAlert = true
                @unknown default:
                    break
                }
            }
        }
    }
    
    /// 이미지 공유
    func share() {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows
            .first else {
            print("Failed to fetch the key window.")
            return
        }
        
        let screenshot = window.screenShot // 전체 창 캡처
        let activityViewController = UIActivityViewController(activityItems: [screenshot], applicationActivities: nil)
        guard let rootVC = window.rootViewController else { return }
        rootVC.present(activityViewController, animated: true)
    }
}

// UIView에 ScreenShot을 넣기 위함
extension UIView {
    var screenShot: UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: self.bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

// View에 ScreenShot을 넣기 위함

extension View {
    func takeScreenshot(origin: CGPoint, size: CGSize) -> UIImage {
        let window = UIWindow(frame: CGRect(origin: origin, size: size))
        let hosting = UIHostingController(rootView: self)
        hosting.view.frame = window.frame
        window.addSubview(hosting.view)
        window.makeKeyAndVisible()
        return hosting.view.screenShot
    }
    
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
}


#Preview {
    SendAndShareButton()
}
