//
//  TestView.swift
//  BiRTH
//
//  Created by 이소현 on 11/15/24.
//

import UIKit
import SwiftUI

struct TestSoyView: View {
    
    @State private var pastedImage: UIImage?
    @State private var imagePosition: CGPoint = .zero
    @GestureState private var dragOffset: CGSize = .zero
    
    var body: some View {
        ZStack {
            
            EditMenuPresentView(pastedImage: $pastedImage, imagePosition: $imagePosition)
            
            VStack {
                Spacer()
                
                if let pastedImage = pastedImage {
                    Image(uiImage: pastedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .position(imagePosition)
                        .offset(dragOffset)
                        .gesture(
                            DragGesture()
                                .updating($dragOffset) { value, state, _ in
                                    state = value.translation
                                }
                                .onEnded { value in
                                    imagePosition.x += value.translation.width
                                    imagePosition.y +=
                                    value.translation.height
                                }
                        )
                }
                
                ExportSafariButton()

            }
        }
        .padding()
    }
}

extension TestSoyView {
    func pasteImageFromClipboard() {
        if let image = UIPasteboard.general.image {
            pastedImage = image
        }
    }
}

#Preview {
    TestSoyView()
}
