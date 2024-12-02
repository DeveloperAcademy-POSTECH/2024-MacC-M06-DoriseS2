//
//  SplashView.swift
//  BiRTH
//
//  Created by chanu on 11/26/24.
//

import SwiftUI

struct SplashView: View {
    
    @AppStorage("isFirstOnboarding") var isFirstOnboarding: Bool = true
    
    var body: some View {
        Image("birthsplashview")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
