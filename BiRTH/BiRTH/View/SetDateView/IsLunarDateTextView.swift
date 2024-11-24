//
//  IsLunarDateTextView.swift
//  BiRTH
//
//  Created by Hajin on 11/20/24.
//

import SwiftUI

//struct IsLunarDateTextView: View {
//
//    @Binding var dateOfBday: Date
//
//    var body: some View {
//        VStack {
//            if let lunarDate = KoreanLunarSolarConverter.instance.solarToLunar(date: dateOfBday), let _ =
//                KoreanLunarSolarConverter.instance.convertLunarToSolarForCurrentYear(lunarDate: lunarDate)
//            {
//                HStack {
//                    Text("양력과 음력은 약 30일 정도 차이가 나요")
//                        .font(.system(size: 10, weight: .semibold))
//                        .foregroundColor(.gray)
//                    Spacer()
//                }.padding(0)
//
//                HStack {
//                    Text("음력: \(lunarDate, formatter: SaveBdayView.dateFormat)")
//                        .foregroundColor(.gray)
//                    Spacer()
//                }
//                .padding(0)
//            }
//        }
//    }
//}
