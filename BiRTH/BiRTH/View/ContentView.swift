//
//  ContentView.swift
//  BiRTH
//
//  Created by chanu on 11/26/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("firstLaunch") var firstLaunch: Bool = true
    @State var isLoading: Bool = true
    
    var body: some View {
        if isLoading {
            SplashView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                        withAnimation {
                            isLoading = false
                        }
                    }
                }
        } else {
            if firstLaunch {
                OnBoardingView()
            }
        else {
                //걍 이리 해놈.
                IndicatorView(tabSelection: .constant(1))
            }
        }
    }
}

#Preview {
    ContentView()
}
