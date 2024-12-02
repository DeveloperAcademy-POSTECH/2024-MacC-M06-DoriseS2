//
//  HeaderForSaveBdayView.swift
//  BiRTH
//
//  Created by Hajin on 11/20/24.
//

import SwiftUI

struct HeaderForSaveBdayView: View {

    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss

    var bFriend: BFriend? // 수정 대상

    @Binding var name: String
    @Binding var dateOfBday: Date
    @Binding var notiFrequency: [String]
    @Binding var imageData: Data?
    @Binding var profileImage: Data? 
    @Binding var relationshipTag: [String]
    @Binding var isEditing: Bool

    var body: some View {
        Text("")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: saveOrUpdateFriend) {
                        Text("저장")
                            .foregroundColor(.black)
                            .font(.biRTH_bold_18)
                    }
                }
            }
    }

    private func saveOrUpdateFriend() {
        if let existingFriend = bFriend {
            // 수정 로직
            existingFriend.name = name
            existingFriend.birth = dateOfBday
            existingFriend.calcBirthComponents()
            existingFriend.noti = notiFrequency
            existingFriend.profileImage = imageData
            existingFriend.tags = relationshipTag

            do {
                try viewContext.save()
                print("Friend updated successfully!")
            } catch {
                print("Failed to update friend: \(error)")
            }
        } else {
            // 새 데이터 저장 로직
            let newFriend = BFriend(context: viewContext)
            newFriend.id = UUID()
            newFriend.name = name
            newFriend.birth = dateOfBday
            newFriend.calcBirthComponents()
            newFriend.noti = notiFrequency
            newFriend.profileImage = imageData
            newFriend.tags = relationshipTag

            do {
                try viewContext.save()
                print("New friend saved successfully!")
            } catch {
                print("Failed to save new friend: \(error)")
            }
        }
        dismiss()
    }
}

extension HeaderForSaveBdayView {
    func lunarToFinalDate() {
            dateOfBday = dateOfBday


    }
}
