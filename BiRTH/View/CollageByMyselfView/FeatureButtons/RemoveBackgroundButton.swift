//
//  RemoveBackgroundButton.swift
//  BiRTH
//
//  Created by 이소현 on 11/26/24.
//

import SwiftUI

struct RemoveBackgroundButton: View {
    
    var processingQueue = DispatchQueue(label: "ProcessingQueue")
    
    @Binding var image: UIImage
    
    var body: some View {
        Button {
            createSticker()
            print("removeImageBackground")
        } label: {
            FeatureCircle(colorHex: "9694FF", featureImgName: "wand.and.rays", featureName: "배경제거")
        }
    }
}

//#Preview {
//    RemoveBackgroundButton()
//}
