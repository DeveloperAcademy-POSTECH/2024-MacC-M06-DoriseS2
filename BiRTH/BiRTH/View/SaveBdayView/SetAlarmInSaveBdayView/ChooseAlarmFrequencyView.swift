//
//  ChooseAlarmFrequencyView.swift
//  BiRTH
//
//  Created by Hajin on 11/20/24.
//
import SwiftUI

struct ChooseAlarmFrequencyView: View {

    @Binding var notiFrequency: [String]

    let notiArray: [String] = ["당일", "1일 전", "3일 전", "7일 전"]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack  {
                ForEach(notiArray, id: \.self) { noti in
                    Button {
                        if notiFrequency.contains(noti) {
                            notiFrequency.removeAll { $0 == noti }
                        } else {
                            notiFrequency.append(noti)
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 90)
                                .overlay(RoundedRectangle(cornerRadius: 90)
                                    .strokeBorder(Color.biRTH_pointColor, lineWidth: 1))
                                .foregroundColor(notiFrequency.contains(noti) ? Color.biRTH_pointColor : Color.white)
                                .frame(width: 58, height: 33)
                            
                            Text(noti)
                                .foregroundColor(notiFrequency.contains(noti) ? .white : .black)
                                .font(.biRTH_semibold_14)
                        }
                    }
                }
            }
        }.padding(.init(top: 0, leading: 26, bottom: 0, trailing: 38))
    }
}

#Preview {
    ChooseAlarmFrequencyView(notiFrequency: .constant([]))
}
