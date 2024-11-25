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
        NavigationStack {
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: 24) {
                    ExportSafariButton()
                    BackgroundColorButton()
                        .environmentObject(colorManager)
                }
            }
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    XmarkButton()
                }
            }
        }
    }
}

#Preview {
    ButtonSheet()
}
