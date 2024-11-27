//
//  HeaderForSaveBdayView.swift
//  BiRTH
//
//  Created by Hajin on 11/20/24.
//

import SwiftUI

struct HeaderForSaveBdayView: View {
    
    @Binding var isEditing: Bool


    @Environment(\.managedObjectContext) var viewContext
    
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    var bFriend: BFriend? = nil

    @Binding var name: String
    @Binding var dateOfBday: Date
    @Binding var notiFrequency: [String]
    @Binding var imageData: Data?
    @Binding var relationshipTag: [String]
    @Binding var profilrImage: Data?
    
    var body: some View {
        Text("")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    BackButton()
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        print("1")
                        if let existingFriend = bFriend {
                            // 수정 로직
                            print("2")
                            do {
                                if let bFriendUpdate = try viewContext.existingObject(with: existingFriend.objectID) as? BFriend {
                                    bFriendUpdate.name = name
                                    bFriendUpdate.birth = dateOfBday
                                    bFriendUpdate.noti = notiFrequency
                                    bFriendUpdate.profileImage = imageData
                                    bFriendUpdate.tags = relationshipTag

                                    saveData(viewContext: viewContext)
                                }
                            } catch {
                                let nsError = error as NSError
                                fatalError("Error: \(nsError), \(nsError.userInfo)")
                            }
                        } else {
                            print("3")
                            // 저장 로직
                            saveBFriend(viewContext: viewContext, name: name, dateOfBday: dateOfBday, notiFrequency: notiFrequency, imageData: imageData, relationshipTag: relationshipTag)
                        }
                        print("4")
                        dismiss()
                        print("5")
                    } label: {
                        Text("저장")
                            .foregroundColor(.black)
                            .font(.biRTH_bold_18)
                    }
                }
            }
    }
}

//extension HeaderForSaveBdayView {
//    func saveBday() {
//        //수정 혹은 생성 if else문 필요.
//        //음력 변환 로직을 이 함수에 뺴냄.
//        if let bFriend = bFriend {
//            // 기존 생일 수정
//            print("기존 생일 수정 중")
//            bFriend.name = name
//            bFriend.dateOfBday = dateOfBday
//            bFriend.isLunar = isLunar
//            bFriend.profileImage = imageData
//            bFriend.notiFrequency = notiFrequency
//            bFriend.relationshipTag = relationshipTag
//
//        } else {
//            lunarToFinalDate()
//
//            // 새 생일 객체를 저장
//            let newBday = Bday(id: UUID(), name: name, profileImage: imageData, dateOfBday: dateOfBday, isLunar: isLunar, notiFrequency: notiFrequency, relationshipTag: relationshipTag)
//            context.insert(newBday)
//
//            NotificationManager.instance.scheduleNotification(for: name, dateOfBday: dateOfBday, notiFrequency: notiFrequency)
//        }
//    }
//}

extension HeaderForSaveBdayView {
    func lunarToFinalDate() {
        // 사용자가 음력을 선택했을 경우
//        if isLunar {
//            // 양력 -> 음력 변환
//            //            if let lunarDate = KoreanLunarSolarConverter.instance.solarToLunar(date: dateOfBday) {
//            //                // 변환된 음력 날짜를 현재 연도의 양력 날짜로 변환
//            //                dateOfBday = KoreanLunarSolarConverter.instance.convertLunarToSolarForCurrentYear(lunarDate: lunarDate) ?? dateOfBday
//            //            } else {
//            // 음력 변환 실패 시, 기본으로 사용한 양력 날짜 사용
//            dateOfBday = dateOfBday
//            //            }
//        } else {
            // 사용자가 음력을 선택하지 않았을 경우.
            dateOfBday = dateOfBday
//        }
    }
}
