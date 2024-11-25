//
//  ColByMyselfBottomView.swift
//  BiRTH
//
//  Created by 이소현 on 11/25/24.
//

import SwiftUI

struct ColByMyselfBottomView: View {
    @EnvironmentObject var colorManager: ColorManager
    @State var showingButtonSheet = false
    
    var body: some View {
        Button {
            showingButtonSheet.toggle()
        } label: {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 40))
                .foregroundStyle(Color.biRTH_pointColor)
        }
        .padding(.vertical, 5)
        .sheet(isPresented: $showingButtonSheet) {
            ButtonSheet()
                .environmentObject(colorManager)
                .presentationDetents([.fraction(0.25)])
        }
    }
}

#Preview {
    ColByMyselfBottomView()
}
