//
//  ExportSafariButton.swift
//  BiRTH
//
//  Created by 이소현 on 11/18/24.
//

import SwiftUI

struct ExportSafariButton: View {
    @State private var showingSafariSheet = false
    @State private var safariURL = URL(string: "https://www.google.com")!
    
    var body: some View {
        Button {
            showingSafariSheet.toggle()
        } label: {
            FeatureCircle(colorHex: "80C4E9", featureImgName: "safari", featureName: "사파리")
        }
        .sheet(isPresented: $showingSafariSheet) {
                SafariSheet(url: safariURL)
                .presentationDetents([.medium, .large])
        }
    }
}

#Preview {
    ExportSafariButton()
}



