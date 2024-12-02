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
                .font(.biRTH_semibold_20)
            Spacer()
        }.padding(.init(top: 0, leading: 24, bottom: 3, trailing: 45))

        HStack {
            Text("해당 날짜의 오전 9시에 생일 알림을 보내드려요")
                .font(.biRTH_regular_12)
            Spacer()
        }.padding(.init(top: 0, leading: 25, bottom: 22, trailing: 45))

        ChooseAlarmFrequencyView(notiFrequency: $notiFrequency)
    }
}

#Preview {
    // .constant를 이용해 빈 배열[]을 바인딩
    SetAlarmInSaveBdayView(notiFrequency: .constant([]))
}
