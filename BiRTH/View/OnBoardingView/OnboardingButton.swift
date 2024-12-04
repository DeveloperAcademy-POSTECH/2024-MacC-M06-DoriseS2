//
//  OnboardingButton.swift
//  BiRTH
//
//  Created by chanu on 11/26/24.
//


//
//  OnboardingButton.swift
//  STOD
//
//  Created by hannback on 5/20/24.
//

import SwiftUI

struct OnboardingButton: View {
    
    @Binding var tabSelection: Int
    @AppStorage("isFirstOnboarding") var isFirstOnboarding: Bool = true
    
    var body: some View {
        Button {
            print("버튼 클릭. 온보딩 안뜸.")
            isFirstOnboarding = false
        } label: {
            HStack {
                Spacer()
                Text("시작하기!")
                    .font(.biRTH_semibold_16)
                    .foregroundStyle(.white)
                Spacer()
            }
            
        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(tabSelection == 1 ? .biRTH_pointColor : .biRTH_text1)
                .frame(height: 48)
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 30, trailing: 16))
        .disabled(tabSelection != 1)
    }
}
