//
//  ColByMyselfTopView.swift
//  BiRTH
//
//  Created by 이소현 on 11/25/24.
//

import SwiftUI


struct ColByMyselfTopView: View {
    
    @ObservedObject var bFriend: BFriend
    
    //    var friendImage: String
    //    var friendName: String
    //    var remainDday: Int
    //
    var body: some View {
        HStack(spacing: 10) {
            NavigationLink {
                TempFriendDetailView(bFriend: bFriend)
                
            } label: {
                ZStack {
                    
                    if let imageData = bFriend.profileImage,  // 인스턴스에서 접근
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70)
                            .mask {
                                Circle()
                            }
                    } else {
                        Image("photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70)
                            .mask {
                                Circle()
                            }
                    }
                    
                    magnifyImage()
                }
            }
            
            
            
            if let name = bFriend.name {
                Text("TO.\(name)")
                    .font(.biRTH_semibold_18)
                    .foregroundStyle(.black)
            }
            Spacer()
            
            Text(dDaytext(friend: bFriend))
                .font(.biRTH_semibold_16)
                .foregroundStyle(Color.biRTH_text2)
                .padding(.trailing, 10)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
    }
    
    func dDaytext(friend: BFriend) -> String {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        let birthMonth = friend.birthMonth
        let birthDay = friend.birthDay
        let currentYear = calendar.component(.year, from: today)
        
        print("birthMonth, birthDay: \(birthMonth), \(birthDay)")
        
        // 생일이 설정되지 않았을 경우 처리
        guard birthMonth > 0, birthDay > 0 else {
            return "저장된 날짜가 없습니다."
        }
        
        // 현재 연도의 생일 계산
        guard let birthDateThisYear = calendar.date(from: DateComponents(year: currentYear, month: Int(birthMonth), day: Int(birthDay))) else {
            return "날짜 계산 오류"
        }
        
        let daysUntil = calendar.dateComponents([.day], from: today, to: birthDateThisYear).day!
        
        if daysUntil == 0 { // 오늘이 생일인 경우
            return "D-day"
        } else if daysUntil > 0 { // 생일이 아직 오지 않은 경우
            if daysUntil < 31 { // Dday가 30일 남은 경우
                print("\(daysUntil)")
                return "D-\(daysUntil)"
            } else {
                print("\(daysUntil)")
                return ""
            }
            
        } else { // 생일이 지났다면 다음 해 생일로 계산
            
            let absDaysUntil = abs(daysUntil)
            if absDaysUntil < 15 {
                print(absDaysUntil)
                return "D+\(absDaysUntil)"
            } else {
                return ""
            }
        }
    }
}

struct magnifyImage: View {
    var body: some View {
        ZStack {
            Image(systemName: "magnifyingglass.circle.fill")
                .font(.system(size: 20))
                .foregroundStyle(.gray)
                .offset(x: 15, y: 15)
            Image(systemName: "magnifyingglass.circle")
                .font(.system(size: 20))
                .foregroundStyle(.black)
                .offset(x: 15, y: 15)
            
        }
    }
}


