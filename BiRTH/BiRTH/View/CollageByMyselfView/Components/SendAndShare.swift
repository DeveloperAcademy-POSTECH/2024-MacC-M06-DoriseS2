//
//  SendAndShare.swift
//  BiRTH
//
//  Created by 이소현 on 11/25/24.
//

import SwiftUI
import Photos

struct SendAndShare: View {
//    @Binding var targetView: UIView
    @State private var showingAlert: Bool = false
    
    var body: some View {
        Button {
            screenShot()
            print("paperplane")
        } label: {
            Image(systemName: "paperplane")
                .foregroundStyle(.black)
        }
        .alert(isPresented: $showingAlert) {
            let firstButton = Alert.Button.default(Text("공유하기")) {
                share()
            }
            
            let secondButton = Alert.Button.cancel(Text("완료")) {
                print("secondary button pressed")
            }
            return Alert(title: Text("저장하기"),
                         message: Text("이미지를 저장합니다."),
                         primaryButton: firstButton, secondaryButton: secondButton)
        }
    }
}

extension SendAndShare {
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
}

#Preview {
    SendAndShare()
}
