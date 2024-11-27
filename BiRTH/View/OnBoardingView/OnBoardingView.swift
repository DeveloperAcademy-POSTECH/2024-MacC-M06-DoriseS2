//
//  OnBoardingView.swift
//  BiRTH
//
//  Created by chanu on 11/26/24.
//

import SwiftUI

struct OnBoardingView: View {
    
    @State private var tabSelection: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                TabView(selection: $tabSelection) {
                    ForEach(0..<2) { num in
                        if num == 0 {
                            ZStack {
                                Image("onboarding1")
                                    .resizable()
                                    .scaledToFill()
                                
                                VStack{
                                    Spacer()
                                    Text("친구에게 특별한 콜라주를 보내세요.\n친구의 소중한 취향이 잔뜩 담긴 콜라주!")
                                        .font(.biRTH_semibold_20)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.black)
                                }.padding(.bottom,120)
                            }
                        }
                        
                        else if num == 1 {
                            ZStack{
                                Image("onboarding2")
                                    .resizable()
                                    .scaledToFill()
                                    .ignoresSafeArea()
                                VStack{
                                    Spacer()
                                    Text("콜라주레이션 타임!\n내 취향을 다시 보내주는 시간이에요")
                                        .font(.biRTH_semibold_20)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.black)
                                }.padding(.bottom,120)
                            }
                        }
                    }
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                IndicatorView(tabSelection: $tabSelection)
                OnboardingButton(tabSelection: $tabSelection)
            }
            .background(Color.biRTH_mainColor)
        }
    }
}

#Preview {
    OnBoardingView()
}
