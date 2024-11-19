//
//  TestView.swift
//  BiRTH
//
//  Created by 이소현 on 11/15/24.
//

import UIKit
import SwiftUI

struct TestSoyView: View {
    
    @State private var pastedImages: [PastedImage] = []
    @GestureState private var dragOffset: CGSize = .zero
    
    var body: some View {
        ZStack {
            
            EditMenuPresentView(pastedImages: $pastedImages)
            
            VStack {
                ForEach(pastedImages.indices, id: \.self) { index in
                    
                    let pastedImage = pastedImages[index]
                    
                    Image(uiImage: pastedImage.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .position(pastedImage.position)
                        .offset(dragOffset)
                        .gesture(
                            DragGesture()
                                .updating($dragOffset) { value, state, _ in
                                    state = value.translation
                                }
                                .onEnded { value in
                                    pastedImages[index].position.x = pastedImage.position.x + value.translation.width
                                    pastedImages[index].position.y = pastedImage.position.y + value.translation.height
                                }
                        )
                }
                
                
                
                ExportSafariButton()
                
            }
        }
        .padding()
    }
}

struct PastedImage: Identifiable {
    let id = UUID()
    var image: UIImage
    var position: CGPoint
}


#Preview {
    TestSoyView()
}
