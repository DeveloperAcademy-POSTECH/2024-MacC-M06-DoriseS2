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
    
    @State var isAbleClosed = false
    
    var processingQueue = DispatchQueue(label: "ProcessingQueue")
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows) {
                        Button {
                            createSticker()
                            print("removeImageBackground")
                        } label: {
                            FeatureCircle(colorHex: "9694FF", featureImgName: "wand.and.rays", featureName: "배경제거")
                        }
                    }
                }
            }
            .padding(.horizontal)
            .interactiveDismissDisabled(!isAbleClosed)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    XmarkButton()
                }
            }
        }
    }
}



