//
//  RemoveImageBackgroundSheet.swift
//  BiRTH
//
//  Created by 이소현 on 11/23/24.
//

import SwiftUI
import UIKit


struct CustomSheet: View {
    let rows = [GridItem(.flexible())]
    
    @Binding var image: UIImage
    @Binding var sheetHeight: CGFloat
    @Binding var isCustomSheet: Bool
    
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            if isCustomSheet {
                EmptyView()
                    .opacity(0)
                    .ignoresSafeArea()
            }
            
            ZStack(alignment: .topTrailing) {

                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, spacing: 24) {
                        RemoveBackgroundButton(image: $image)
                        DeleteButton()
                    }
                    .padding()
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Button {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isCustomSheet = false
                        }
                    } label: {
                        Image(systemName: "xmark.circle")
                            .foregroundStyle(.black)
                            .font(.system(size: 24))
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 14)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(maxHeight: sheetHeight)
            .background(.yellow)
            .cornerRadius(16, corners: .topLeft)
            .cornerRadius(16, corners: .topRight)
            .transition(.move(edge: .bottom))
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut(duration: 0.5), value: isCustomSheet)
    }
}




struct CustomSheet_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            CustomSheetWrapper()
        }
    }
}

// 프리뷰에서 사용하는 래퍼 뷰
struct CustomSheetWrapper: View {
    @State private var image: UIImage = UIImage(named: "exampleImage") ?? UIImage() // 기본 이미지를 설정하거나 빈 UIImage를 사용
    @State private var sheetHeight: CGFloat = UIScreen.main.bounds.height * 0.2
    @State private var isCustomSheet: Bool = true
    
    var body: some View {
        CustomSheet(image: $image, sheetHeight: $sheetHeight, isCustomSheet: $isCustomSheet)
            .previewLayout(.sizeThatFits)
    }
}
