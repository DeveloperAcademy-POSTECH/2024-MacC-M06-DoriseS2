//
//  ColByMyselfBottomView.swift
//  BiRTH
//
//  Created by 이소현 on 11/25/24.
//

import SwiftUI
import CoreData

struct ColByMyselfBottomView: View {
    
    @EnvironmentObject var colorManager: ColorManager
    @State var showingButtonSheet = false
    @Binding var selectedPhotos: [PastedImage]
    
   
    
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
            ButtonSheet(selectedPhotos: $selectedPhotos)
                .presentationBackground(.black)
                .environmentObject(colorManager)
                .presentationDetents([.fraction(0.2)])
        }
    }
}


//#Preview {
//    ColByMyselfBottomView()
//}
