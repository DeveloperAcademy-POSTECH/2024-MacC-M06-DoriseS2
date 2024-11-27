//
//  DeleteButton.swift
//  BiRTH
//
//  Created by 이소현 on 11/26/24.
//

import SwiftUI

struct DeleteButton: View {
    var body: some View {
        Button {
            print("Delete Button")
        } label: {
            FeatureCircle(colorHex: "F96E2A", featureImgName: "trash", featureName: "사진삭제")
        }
    }
}

#Preview {
    DeleteButton()
}
