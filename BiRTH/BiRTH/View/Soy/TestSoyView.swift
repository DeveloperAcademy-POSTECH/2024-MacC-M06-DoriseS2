//
//  TestView.swift
//  BiRTH
//
//  Created by 이소현 on 11/15/24.
//

import UIKit
import SwiftUI

struct TestSoyView: View {
    
    @State var pastedImages: [PastedImage] = []
    
    
    var body: some View {
        ZStack {
            
            EditMenuPresentView(pastedImages: $pastedImages)
            
            ForEach(pastedImages.indices, id: \.self) { index in
                
                Image(uiImage: pastedImages[index].image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200 * pastedImages[index].scale, height: 200 * pastedImages[index].scale)
                    .position(pastedImages[index].position)
                    .offset(pastedImages[index].dragOffset)
                    .scaleEffect(1 + pastedImages[index].currentAmount + pastedImages[index].lastAmount)
                    .rotationEffect(pastedImages[index].angle)
                    .simultaneousGesture(dragGesture(index: index))
                    .simultaneousGesture(magnificationGesture(index: index))
                    .simultaneousGesture(rotateGesture(index: index))
            }
        }
        
        ExportSafariButton()
    }
}




#Preview {
    TestSoyView()
}
