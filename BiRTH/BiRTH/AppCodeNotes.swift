//
//  AppCodeNotes.swift
//  BiRTH
//
//  Created by 이소현 on 12/3/24.
//

import Foundation

// MARK: - CollageByMyselfView
// isCustomSheet
//CustomSheet(
//    image: $pastedImages[selectedIndex].pastedImage,
//    sheetHeight: $sheetHeight,
//    isCustomSheet: $isCustomSheet,
//    pastedImages: $pastedImages,
//    selectedImageID: $selectedImageID
//)
//.transition(.move(edge: .bottom))
//.animation(.easeInOut(duration: 0.5), value: isCustomSheet)


// MARK: - CustomSheet
//if isCustomSheet {
//    EmptyView()
//        .opacity(0)
//        .ignoresSafeArea()
//}
//
//ZStack(alignment: .topTrailing) {
//
//    ScrollView(.horizontal) {
//        LazyHGrid(rows: rows, spacing: 24) {
//
//            RemoveBackgroundButton(image: $image)
//            DeleteButton(pastedImages: $pastedImages, selectedImageID: $selectedImageID)
//
//        }
//        .padding()
//        Spacer()
//    }
//    
//    HStack {
//        Spacer()
//        Button {
//            withAnimation(.easeInOut(duration: 0.5)) {
//                isCustomSheet = false
//            }
//        } label: {
//            Image(systemName: "xmark.circle")
//                .foregroundStyle(.black)
//                .font(.system(size: 24))
//        }
//        .padding(.vertical)
//        .padding(.horizontal, 14)
//    }
//}
//.frame(maxWidth: .infinity)
//.frame(maxHeight: sheetHeight)
//.background(.white)
//.cornerRadius(16, corners: .topLeft)
//.cornerRadius(16, corners: .topRight)
//.transition(.move(edge: .bottom))
//
//}
//.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
//.ignoresSafeArea()
//.animation(.easeInOut(duration: 0.5), value: isCustomSheet)
