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
                    Button {
                        print("back 이전 뷰로 돌아갑니다. FriendListView")
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        print("1")
                        if let existingFriend = bFriend {

                            print("Existing friend: \(existingFriend)")
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

extension HeaderForSaveBdayView {
    func lunarToFinalDate() {
            dateOfBday = dateOfBday
    }
}
