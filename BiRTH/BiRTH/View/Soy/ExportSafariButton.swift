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
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 100, height: 100)
                
                Image(systemName: "safari")
                    .font(.system(size: 70))
                    .foregroundStyle(.white)
                    
            }
                
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

