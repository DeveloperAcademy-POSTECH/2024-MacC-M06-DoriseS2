import SwiftUI

struct GestureRecognizerView: UIViewRepresentable {
    @Binding var pastedImage: PastedImage

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.isUserInteractionEnabled = true // 제스처 인식을 위해 필요

        // Pinch Gesture Recognizer (확대/축소)
        let pinchGesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePinch(_:)))
        view.addGestureRecognizer(pinchGesture)

        // Rotation Gesture Recognizer (회전)
        let rotationGesture = UIRotationGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleRotation(_:)))
        view.addGestureRecognizer(rotationGesture)

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: GestureRecognizerView

        init(_ parent: GestureRecognizerView) {
            self.parent = parent
        }

        @objc func handlePinch(_ sender: UIPinchGestureRecognizer) {
            guard sender.state == .changed else { return }
            parent.pastedImage.imageWidth *= sender.scale
            parent.pastedImage.imageHeight *= sender.scale
            sender.scale = 1.0 // 스케일 초기화
        }

        @objc func handleRotation(_ sender: UIRotationGestureRecognizer) {
            guard sender.state == .changed else { return }
            parent.pastedImage.angleSum += sender.rotation * 180 / .pi
            parent.pastedImage.angle = .degrees(parent.pastedImage.angleSum)
            sender.rotation = 0 // 회전 초기화
        }
    }
}
