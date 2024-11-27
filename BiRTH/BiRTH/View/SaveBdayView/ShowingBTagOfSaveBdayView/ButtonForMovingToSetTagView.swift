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
                Text("+")
                    .font(.biRTH_bold_16)
                    .foregroundColor(Color.biRTH_pointColor)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 7)
                    .overlay(RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(Color.biRTH_pointColor, lineWidth: 1))
                    .frame(height: 34)
                    .background(Color.white)
                    .cornerRadius(20)
        }
        .sheet(isPresented: $isshowingSheetForCreatingTag) {
            SetTagView(isshowingSheetForCreatingTag: $isshowingSheetForCreatingTag)
                .presentationDragIndicator(.visible)
                .presentationDetents([.medium])
        }
    }
}

#Preview {
    ButtonForMovingToSetTagView(isshowingSheetForCreatingTag: .constant(false))
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
