//
//  SetAlarmInSaveBdayView.swift
//  BiRTH
//
//  Created by Hajin on 11/20/24.
//

import SwiftUI

struct SetAlarmInSaveBdayView: View {

    @Binding var notiFrequency: [String]

    var body: some View {
        //MARK: 알람 여부
        HStack {
            Text("알람 여부")
                .font(.system(size: 18, weight: .semibold))
            Spacer()
        }.padding(.init(top: 5, leading: 45, bottom: 2, trailing: 45))

        HStack {
            Text("해당 날짜의 오전 9시에 생일 알림을 보내드려요")
                .font(.system(size: 12, weight: .light))
            Spacer()
        }.padding(.init(top: 0, leading: 45, bottom: 2, trailing: 45))

        ChooseAlarmFrequencyView(notiFrequency: $notiFrequency)
    }
}
