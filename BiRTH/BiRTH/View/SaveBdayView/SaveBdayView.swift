//
//  SaveBdayView.swift
//  BiRTH
//
//  Created by Hajin on 11/20/24.
//

import SwiftUI
import SwiftData
import CoreData
import PhotosUI

//import KoreanLunarSolarConverter
//최상단뷰
struct SaveBdayView: View {
    @Environment(\.modelContext) var context

    @State private var isEditing = false

    // State variables for user inputs
    @State private var name = ""
    @State private var profileImage: Data?
    @State private var dateOfBday: Date = Date()
    @State private var notiFrequency = [""]
    @State private var relationshipTag = [""]

    @State private var selectedItem: PhotosPickerItem?

    @State private var isshowingSheetForSettingDate = false
    @State private var isshowingSheetForCreatingTag = false

    // Fetched results for tags
    @FetchRequest(
        entity: BTag.entity(),
        sortDescriptors: []
    )
    private var bTags: FetchedResults<BTag>

    var bFriend: BFriend? = nil

    @Environment(\.dismiss) var dismiss

    @State private var imageData: Data?

    static let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY. M. d"
        return formatter
    }()

    var body: some View {
            VStack {
                HeaderForSaveBdayView(isEditing: $isEditing, bFriend: bFriend, name: $name, dateOfBday: $dateOfBday, notiFrequency: $notiFrequency, imageData: $imageData, relationshipTag: $relationshipTag, profilrImage: $profileImage)

                Spacer(minLength: 26)
                
                PhotoPickerForSaveBdayView(imageData: $imageData, selectedItem: $selectedItem)
                
                Spacer(minLength: 47)
                
                SetNameForSaveBdayView(name: $name)
                
                Spacer(minLength: 27.5)
                
                SetBirthForSaveBdayView(dateOfBday: $dateOfBday, isshowingSheetForSettingDate: $isshowingSheetForSettingDate)
                
                Spacer(minLength: 29)
                
                
                ShowingBTagOfSaveBdayView(bTags: bTags, relationshipTag: $relationshipTag, isshowingSheetForCreatingTag: $isshowingSheetForCreatingTag)
                
                Spacer(minLength: 28)
                
                SetAlarmInSaveBdayView(notiFrequency: $notiFrequency)
                
                Spacer(minLength: 82)
            } //: VSTACK
            .background(Color.biRTH_mainColor)
        .onAppear {
            // Optionally initialize additional state when view appears
            if let bFriend = bFriend {
                self.name = bFriend.name ?? ""
                self.profileImage = bFriend.profileImage
                self.dateOfBday = bFriend.birth ?? Date()
                self.notiFrequency = bFriend.noti ?? [""]
                self.relationshipTag = bFriend.tags ?? [""]
                isEditing = true
            }
        }
    }
}


//#Preview {
//    SaveBdayView()
//}
