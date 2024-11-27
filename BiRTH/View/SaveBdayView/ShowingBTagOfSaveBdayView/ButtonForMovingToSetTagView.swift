//
//  ButtonForMovingToSetTagView.swift
//  BiRTH
//
//  Created by Hajin on 11/20/24.
//

import SwiftUI

struct ButtonForMovingToSetTagView: View {

    @Binding var isshowingSheetForCreatingTag: Bool

    var body: some View {
        Button {
            isshowingSheetForCreatingTag.toggle()
        } label: {
            ZStack {
                Text("+")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(Color.init(hex: "0A84FF"))
                    .padding()
                    .frame(height: 43)
                    .background(Color.init(hex: "0A84FF").opacity(0.15))
                    .cornerRadius(40)
            }
        }
        .sheet(isPresented: $isshowingSheetForCreatingTag) {
            SetTagView(isshowingSheetForCreatingTag: $isshowingSheetForCreatingTag)
                .presentationDragIndicator(.visible)
                .presentationDetents([.medium])
        }
    }
}
