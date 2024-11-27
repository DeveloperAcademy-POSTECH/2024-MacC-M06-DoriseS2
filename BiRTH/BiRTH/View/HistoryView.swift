//
//  HistoryView.swift
//  BiRTH
//
//  Created by chanu on 11/26/24.
//

import SwiftUI

struct HistoryView: View {
    
    let currentDate: String = {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let dateString = formatter.string(from: now)
        
        formatter.dateFormat = "E"
        formatter.locale = Locale(identifier: "ko_KR")
        let weekday = formatter.string(from: now)
        
        return "\(dateString)(\(weekday))"
    }()
    
    var body: some View {
        ZStack{
            Color.biRTH_mainColor
                .ignoresSafeArea()
            
                AView
            
            
            
            
        }
    }
}
//
//extension HistoryView {
//    @ViewBuilder
//    private func selectView(foo: Bool) -> some View {
//        if(foo){
//            AView
//        }else {
//            BView
//        }
//    }
//}

extension HistoryView {
    private var AView : some View {
        VStack{
            
            Image("xmark")
                .resizable()
                .scaledToFill()
                .frame(width: 25, height: 25)
                .padding(.bottom,10)
            
            Text("히스토리가 없어요 😢").font(.biRTH_bold_18)
            Text("친구와 콜라쥬레이션을 즐겨보세요!").font(.biRTH_regular_14)
            
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    print("뒤로!")
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("히스토리")
        
    }
    
    private var BView : some View {
        VStack{
            Text(currentDate)
                .font(.biRTH_regular_12)
                .foregroundColor(.biRTH_text1)
                .padding()
            
            HStack{
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 45, height: 45)
                    .background(
                        Image("photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 45, height: 45)
                            .clipped()
                    )
                    .cornerRadius(45)
                
                ZStack{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 204, height: 252)
                        .background(
                            Image("images")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 204, height: 252)
                                .clipped()
                        )
                        .cornerRadius(15)
                    
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 204, height: 48)
                            .background(.black.opacity(0.75))
                            .cornerRadius(15)
                        
                        Text("내가 콜라주를 보냈어요!")
                            .font(.biRTH_regular_14)
                            .foregroundStyle(.white)
                        
                    }.padding(.top,205)
                }
                Spacer()
            }.padding(.top,15)
                .padding(.leading,15)
                .padding(.bottom,25)
            
            
            HStack{
                Spacer()
                ZStack{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 204, height: 252)
                        .background(
                            Image("images")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 204, height: 252)
                                .clipped()
                        )
                        .cornerRadius(15)
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 204, height: 48)
                            .background(.black.opacity(0.75))
                            .cornerRadius(15)
                        
                        Text("친구가 콜라주를 보냈어요!")
                            .font(.biRTH_regular_14)
                            .foregroundStyle(.white)
                    }.padding(.top,205)
                    
                }
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 45, height: 45)
                    .background(
                        Image("photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 45, height: 45)
                            .clipped()
                    )
                .cornerRadius(45)
            }                .padding(.trailing,15)

            
            Spacer()
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    print("뒤로!")
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("히스토리")
    }
}

#Preview {
    NavigationStack {
        HistoryView()
    }
}

