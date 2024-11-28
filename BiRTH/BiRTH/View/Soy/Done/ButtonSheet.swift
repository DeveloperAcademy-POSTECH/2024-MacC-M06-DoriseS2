//
//  SheetView.swift
//  BiRTH
//
//  Created by 이소현 on 11/21/24.
//

import SwiftUI

struct ButtonSheet: View {

    let rows = [GridItem(.flexible())]
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var colorManager: ColorManager

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
                    ExportSafariButton()
                    BackgroundColorButton()
                        .environmentObject(colorManager)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ButtonSheet()
}
