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
            Circle()
                .frame(width: 50, height: 50)
                .foregroundStyle(Color(hex: "9FCF8E"))
                .overlay {
                    Image(systemName: "paintbrush.pointed")
                        .font(.system(size: 30))
                        .foregroundStyle(.black)
                }
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

