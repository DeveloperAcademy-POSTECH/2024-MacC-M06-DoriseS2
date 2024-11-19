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
//    @State private var scale: CGFloat = 1.0
    @GestureState private var scaleDelta: CGFloat = 1.0
    @GestureState private var dragOffset: CGSize = .zero
    
    var body: some View {
        ZStack {
            
            EditMenuPresentView(pastedImages: $pastedImages)
            
            ForEach(pastedImages.indices, id: \.self) { index in
                
                Image(uiImage: pastedImages[index].image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200 * pastedImages[index].scale, height: 200 * pastedImages[index].scale)
                    .position(pastedImages[index].position)
                    .simultaneousGesture(
                        DragGesture()
                            .updating($dragOffset) { value, state, _ in
                                state = value.translation
                            }
                            .onEnded { value in
                                pastedImages[index].position.x += value.translation.width
                                pastedImages[index].position.y += value.translation.height
                                
                            }
                    )
                    .simultaneousGesture(
                        MagnifyGesture()
                            .updating($scaleDelta) { value, state, _ in
                                state = value.magnification
                            }
                            .onEnded { value in
                                pastedImages[index].scale *= value.magnification
                            }
                    )
            }
        }
        
        ExportSafariButton()
    }
}

struct PastedImage: Identifiable {
    let id = UUID()
    var image: UIImage
    var position: CGPoint
    var scale: CGFloat = 1.0
    var state: CGFloat = 1.0
}


#Preview {
    TestSoyView()
}
