//
//  EditMenuPresentView.swift
//  BiRTH
//
//  Created by 이소현 on 11/18/24.
//

import SwiftUI
import UIKit


struct EditMenuPresentView: UIViewRepresentable {
    @Binding var pastedImages: [PastedImage]
    
    /// Inherited from UIViewRepresentable.makeUIView(context:).
    /// Paste가 가능한 View를 생성합니다.
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .systemGray6

        // Add Edit Menu Interaction
        let editMenuInteraction = UIEditMenuInteraction(delegate: context.coordinator)
        view.addInteraction(editMenuInteraction)

        // Add Tap Gesture Recognizer
        let tapRecognizer = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.didTap(_:)))
        view.addGestureRecognizer(tapRecognizer)

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(pastedImages: $pastedImages)
    }

    class Coordinator: NSObject, UIEditMenuInteractionDelegate {
        @Binding var pastedImages: [PastedImage]

        init(pastedImages: Binding<[PastedImage]>) {
            _pastedImages = pastedImages
        }
        
        /// Inherited from UIEditMenuInteractionDelegate.editMenuInteraction(_:menuFor:suggestedActions:).
        /// editMenu에서 paste가 나타나도록 수정하는 함수입니다. paste를 누르면 클립보드에 저장된 이미지가 view에 붙여넣기 됩니다.
        func editMenuInteraction(
            _ interaction: UIEditMenuInteraction,
            menuFor configuration: UIEditMenuConfiguration,
            suggestedActions: [UIMenuElement]
        ) -> UIMenu? {
            
            let pasteAction = UIAction(title: "Paste", image: UIImage(systemName: "doc.on.clipboard")) { _ in
                if let image = UIPasteboard.general.image {
                    let pastedImage = PastedImage(
                        imageWidth: 150,
                        imageHeight: 150,
                        imagePosition: configuration.sourcePoint,
                        angle: .zero,
                        angleSum: 0,
                        pastedImage: image
                    )
                    self.pastedImages.append(pastedImage)
                } else {
                    print("No image in pasteboard")
                }
            }
            
            return UIMenu(children: [pasteAction])
        }

        func editMenuInteraction(
            _ interaction: UIEditMenuInteraction,
            targetRectFor configuration: UIEditMenuConfiguration
        ) -> CGRect {
            // Define the menu location
            CGRect(x: configuration.sourcePoint.x, y: configuration.sourcePoint.y, width: 1, height: 1)
        }

        /// 사용자가 Tap한 지점을 인지하는 함수입니다. 
        @objc func didTap(_ recognizer: UITapGestureRecognizer) {
            guard let view = recognizer.view else { return }
            let location = recognizer.location(in: view)

            // Present the Edit Menu
            let editMenuInteraction = view.interactions.compactMap { $0 as? UIEditMenuInteraction }.first
            let configuration = UIEditMenuConfiguration(identifier: nil, sourcePoint: location)
            editMenuInteraction?.presentEditMenu(with: configuration)
        }
    }
}

