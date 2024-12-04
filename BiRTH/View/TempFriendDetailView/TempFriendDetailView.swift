//
//  TempFriendDetailView.swift
//  BiRTH
//
//  Created by 이소현 on 11/25/24.
//

import SwiftUI

struct TempFriendDetailView: View {
    @ObservedObject var bFriend: BFriend
    //    @Binding var imageData: Data?
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss

    @State var memo: String = ""

    let colors: [String] = ["2364AA", "3DA5D9", "73BFB9", "FEC601", "EA7317", "FFC97F", "EB7777", "EB8291", "F0BBCD", "C9E7DB"]

    var body: some View {
        ScrollView {
            ZStack {
                // BackgroundColor
                Color.biRTH_mainColor
                
                VStack(spacing: 0){
                    
                    if let imageData = bFriend.profileImage, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 45))
                            .frame(width: 166, height: 168)
                            .padding(.init(top: 26, leading: 0, bottom: 0, trailing: 0))
                    } else {
                        Image("photo")
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 45))
                            .frame(width: 166, height: 168)
                            .padding(.init(top: 26, leading: 0, bottom: 0, trailing: 0))
                    }
                    
                    if let name = bFriend.name {
                        Text(name)
                            .font(.biRTH_bold_36)
                            .foregroundColor(.black)
                            .padding(.init(top: 13, leading: 0, bottom: 0, trailing: 0))
                    }
                    
                    Text(dDaytextForDetail(friend: bFriend))
                        .font(.biRTH_bold_60)
                        .foregroundColor(.biRTH_pointColor)
                    
                    Text(formattedBirthday(friend: bFriend))
                        .font(.biRTH_regular_24)
                        .foregroundColor(.biRTH_text1)
                    
                    HStack {
                        ForEach(bFriend.tags?.compactMap { $0.isEmpty ? nil : $0 } ?? [], id: \.self) { tag in
                            Text(tag)
                                .font(.biRTH_semibold_14)
                                .foregroundColor(.black)
                                .padding(.horizontal, 11)
                                .padding(.vertical, 8)
                                .frame(height: 35)
                                .background(
                                    RoundedRectangle(cornerRadius: 90)
                                        .fill(Color.white)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 90)
                                        .strokeBorder(.blue)
                                )
                        }
                    }.padding(.init(top: 9, leading: 0, bottom: 0, trailing: 0))
                    
                    HStack {
                        Text("메모")
                            .font(.biRTH_semibold_20)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button {
                            //TODO: 저장 버튼 위치 수정
                            bFriend.memo = memo
                            do {
                                try viewContext.save()
                                print("Friend updated successfully!")
                            } catch {
                                print("Failed to update friend: \(error)")
                            }
                        } label: {
                            Text("저장")
                                .font(.biRTH_semibold_20)
                                .foregroundColor(.blue)
                        }
                    }.padding(.init(top: 43, leading: 28, bottom: 10, trailing: 28))
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(hex: "EDEDED"))
                            .frame(width: 342, height:215)
                        
                        if memo == "" {
                            Text("친구의 사소한 취향을 적어보세요")
                                .font(.biRTH_semibold_16)
                                .foregroundColor(.biRTH_text1)
                                .offset(x:-55, y:-75)
                        }
                        TextEditor(text: $memo)
                            .scrollContentBackground(.hidden)
                            .background(Color.clear)
                            .padding()
                            .foregroundColor(.biRTH_text1)
                            .font(.biRTH_semibold_16)
                            .lineSpacing(5) //줄 간격
                            .frame(width: 350, height: 220)
                        
                        
                    }
                    Spacer()
                }
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    // 저장 코드
                    bFriend.memo = memo
                    do {
                        try viewContext.save()
                        print("Friend updated successfully!")
                    } catch {
                        print("Failed to update friend: \(error)")
                    }
                    
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    //TODO: 히스토리뷰
                    HistoryView()
                } label: {
                    Text("히스토리")
                        .font(.biRTH_bold_18)
                        .foregroundColor(.black)
                }
                .padding(.trailing)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    SaveBdayView(bFriend: bFriend)
                } label: {
                    Text("편집")
                        .font(.biRTH_bold_18)
                        .foregroundColor(.black)
                }
            }
        }
        .onAppear() {
                memo = bFriend.memo ?? ""
        }
    }



/// 날짜 MM.DD(E)로 바꿔주는 함수
    func formattedBirthday(friend: BFriend) -> String {
        // Calendar 및 오늘 날짜
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let currentYear = calendar.component(.year, from: today)

        // birthMonth와 birthDay 확인
        let birthMonth = Int(friend.birthMonth) // Int16 -> Int로 변환
        let birthDay = Int(friend.birthDay)     // Int16 -> Int로 변환

        guard birthMonth > 0, birthDay > 0 else {
            return "날짜 정보 없음"
        }

        // 올해의 생일 생성
        guard let birthdayThisYear = calendar.date(from: DateComponents(year: currentYear, month: birthMonth, day: birthDay)) else {
            return "날짜 계산 오류"
        }

        // 날짜 형식화 (MM.dd와 요일)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd(E)" // E는 요일을 나타냄 (금, 토, ...)
        dateFormatter.locale = Locale(identifier: "ko_KR") // 한국어 요일 설정

        return dateFormatter.string(from: birthdayThisYear)
    }



    func dDaytextForDetail(friend: BFriend) -> String {
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
                print("\(daysUntil)")
                return "D-\(daysUntil)"

        } else {// 생일이 지났다면 다음 해 생일로 계산
            let absDaysUntil = abs(daysUntil)
                print(absDaysUntil)
                return "D+\(absDaysUntil)"
        }
    }
}

//#Preview {
//    TempFriendDetailView()
//}
