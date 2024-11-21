//
//  SheetView.swift
//  BiRTH
//
//  Created by 이소현 on 11/21/24.
//

import SwiftUI

struct ButtonSheet: View {
    
    let rows = [GridItem(.flexible())]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows) {
                ExportSafariButton()
            }
        }
    }
}

#Preview {
    ButtonSheet()
}
