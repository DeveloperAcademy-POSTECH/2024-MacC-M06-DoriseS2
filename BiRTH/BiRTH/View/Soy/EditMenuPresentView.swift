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
        
        
        func editMenuInteraction(
            _ interaction: UIEditMenuInteraction,
            menuFor configuration: UIEditMenuConfiguration,
            suggestedActions: [UIMenuElement]
        ) -> UIMenu? {
            
            let pasteAction = UIAction(title: "Paste", image: UIImage(systemName: "doc.on.clipboard")) { _ in
                if let image = UIPasteboard.general.image {
                    let pastedImage = PastedImage(image: image, position: CGPoint(x: 100, y: 100))
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

