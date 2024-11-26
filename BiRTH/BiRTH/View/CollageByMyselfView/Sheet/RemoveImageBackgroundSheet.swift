//
//  RemoveImageBackgroundSheet.swift
//  BiRTH
//
//  Created by 이소현 on 11/23/24.
//

import SwiftUI


struct RemoveImageBackgroundSheet: View {
    let rows = [GridItem(.flexible())]
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var image: UIImage
    @Binding var sheetHeight: CGFloat
    @Binding var isShowingRmImgBgSheet: Bool
    
    
    
    var body: some View {

        ZStack(alignment: .bottom) {
            
            if isShowingRmImgBgSheet {
                EmptyView()
                    .opacity(0)
                    .ignoresSafeArea()
            }
            
            VStack {
                HStack {
                    Spacer()
                    XmarkButton()
                }
                
                Spacer()
                
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows) {
                        
                        RemoveBackgroundButton(image: $image)
                        DeleteButton()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(maxHeight: sheetHeight)
            .background(.yellow)
            .cornerRadius(16, corners: .topLeft)
            .cornerRadius(16, corners: .topRight)
            .transition(.opacity.combined(with: .move(edge: .bottom)))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowingRmImgBgSheet)
    }
}



