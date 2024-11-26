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
    @State var showRemoveImgBg = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle")
                }
            }
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows) {
                    Button {
                        showRemoveImgBg.toggle()
                        print("removeImageBackground")
                    } label: {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                            
                            Image(systemName: "wand.and.rays")
                                .font(.system(size: 30))
                                .foregroundStyle(.black)
                                
                        }
                    }
                    .sheet(isPresented: $showRemoveImgBg) {
                        RemoveImageBackground(image: $image)
                    }
                }
            }
        }
        .padding()
    }
}

//#Preview {
//    RemoveImageBackgroundSheet(image: <#UIImage#>)
//}
