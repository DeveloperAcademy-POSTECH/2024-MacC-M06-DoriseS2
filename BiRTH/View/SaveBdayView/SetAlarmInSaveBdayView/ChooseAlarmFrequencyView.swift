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
                            RoundedRectangle(cornerRadius: 40)
                                .fill(Color.init(hex: "0A84FF"))
                                .opacity(notiFrequency.contains(noti) ? 1 : 0.15)
                                .frame(width: 74, height: 43)
                            Text(noti)
                                .foregroundColor(notiFrequency.contains(noti) ? .white : Color.init(hex: "0A84FF"))
                                .font(.system(size: 15, weight: notiFrequency.contains(noti) ? .bold : .regular))
                        }
                    }
                }
            }
        }.padding(.init(top: 0, leading: 38, bottom: 0, trailing: 38))
    }
}
