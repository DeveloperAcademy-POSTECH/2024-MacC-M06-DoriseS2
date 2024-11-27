//
//  ButtonForCheckingIsLunar.swift
//  BiRTH
//
//  Created by Hajin on 11/20/24.
//

//import SwiftUI
//
//struct ButtonForCheckingIsLunar: View {
//
//    @Binding var isLunar: Bool
//
//    var body: some View {
//        HStack {
//            Button {
//                isLunar = false
//            } label: {
//                ZStack {
//                    RoundedRectangle(cornerRadius: 40)
//                        .fill(Color.init(hex: "0A84FF"))
//                        .opacity(!isLunar ? 1 : 0.15)
//                        .frame(width: 74, height: 43)
//                    Text("양력")
//                        .foregroundColor(!isLunar ? .white : Color.init(hex: "0A84FF"))
//                        .font(.system(size: 15, weight: !isLunar ? .bold : .regular))
//                }
//            }
//
//            Button {
//                isLunar = true
//            } label: {
//                ZStack {
//                    RoundedRectangle(cornerRadius: 40)
//                        .fill(Color.init(hex: "0A84FF"))
//                        .opacity(isLunar ? 1 : 0.15)
//                        .frame(width: 74, height: 43)
//                    Text("음력")
//                        .foregroundColor(isLunar ? .white : Color.init(hex: "0A84FF"))
//                        .font(.system(size: 15, weight: isLunar ? .bold : .regular))
//                }
//            }
//        }
//    }
//}
