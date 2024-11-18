//
//  PasteViewRepresentable.swift
//  BiRTH
//
//  Created by 이소현 on 11/18/24.
//

import UIKit
import Foundation
import SwiftUI


struct PasteViewRepresentable: UIViewRepresentable {
    @Binding var pastedImage: UIImage?
    @Binding var showAlert: Bool
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        let editMenuInteraction = UIEditMenuInteraction(delegate: context.coordinator)
        view.addInteraction(editMenuInteraction)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIEditMenuInteractionDelegate {
        var parent: PasteViewRepresentable
        
        init(parent: PasteViewRepresentable) {
            self.parent = parent
        }
        
        func editMenuInteraction(_ interaction: UIEditMenuInteraction,
                                 menuFor configuration: UIEditMenuConfiguration,
                                 suggestedActions: [UIMenuElement]
                             ) -> UIMenu? {
            let pasteAction = UIAction(title: "Paste", image: UIImage(systemName: "doc.on.clipboard")) { _ in
                if let image = UIPasteboard.general.image {
                    self.parent.pastedImage = image
                } else {
                    self.parent.showAlert = true
                }
            }
            return UIMenu(children: [pasteAction])
        }
        
        func editMenuInteraction(_ interaction: UIEditMenuInteraction, targetRectFor configuration: UIEditMenuConfiguration) -> CGRect {
            return CGRect(x: 150, y: 150, width: 0, height: 0)
        }
    }
}
