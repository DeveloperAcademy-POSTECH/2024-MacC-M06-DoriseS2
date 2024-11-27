//
//  IndicatorView.swift
//  BiRTH
//
//  Created by chanu on 11/26/24.
//


//
//  IndicatorVIew.swift
//  STOD
//
//  Created by hannback on 5/20/24.
//

import SwiftUI

struct IndicatorView: View {
    @Binding var tabSelection: Int
    
    var body: some View {
        HStack {
            ForEach(0..<2) { index in
                Circle()
                    .fill(index == tabSelection ? Color.biRTH_pointColor : Color.gray)
                    .frame(width: 10, height: 10)
                    .onTapGesture {
                        tabSelection = index
                    }
            }
        } .padding(.top, 14)
            .padding(.bottom, 44)
    }
}
