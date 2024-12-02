//
//  FeatureCircle.swift
//  BiRTH
//
//  Created by 이소현 on 11/25/24.
//

import SwiftUI

struct FeatureCircle: View {
    
    var colorHex: String
    var widthAndHeight: CGFloat = 70
    var featureImgName: String
    var imgSize: CGFloat = 35
    var featureName: String
    
    var body: some View {
        VStack {
            Circle()
                .frame(width: widthAndHeight, height: widthAndHeight)
                .foregroundStyle(Color(hex: colorHex))
                .overlay {
                    Image(systemName: featureImgName)
                        .font(.system(size: imgSize))
                        .foregroundStyle(.black)
                }
            
            Text(featureName)
                .font(.biRTH_regular_12)
                .foregroundStyle(.white)
        }
    }

}

#Preview {
    FeatureCircle(colorHex: "4335A7", featureImgName: "paintbrush.pointed.fill", featureName: "배경색상")
}
