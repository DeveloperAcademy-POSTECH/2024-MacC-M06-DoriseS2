//
//  BackgroundColorButton.swift
//  BiRTH
//
//  Created by 이소현 on 11/21/24.
//

import SwiftUI

struct BackgroundColorButton: View {
    @State var showingBackgroundColorSheet = false
    @EnvironmentObject var colorManager: ColorManager
    
    var body: some View {
        Button {
            showingBackgroundColorSheet.toggle()
        } label: {
            FeatureCircle(colorHex: "9FCF8E", featureImgName: "paintbrush.pointed", featureName: "배경색상")
        }
        .sheet(isPresented: $showingBackgroundColorSheet) {
            BackgroundColorSheet()
                .presentationDetents([.fraction(0.2)])
        }
    }
}

#Preview {
    BackgroundColorButton()
}
