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

    // State variables for user inputs
    @State private var name = ""
    @State private var profileImage: Data?
    @State private var dateOfBday: Date = Date()
    @State private var isLunar = false
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

    
//    @FetchRequest(
//        entity: BFriend.entity(),
//        sortDescriptors: []
//    )
//    private var bFriend: FetchedResults<BFriend?>
    // Optional BFriend object
    private var bFriend: BFriend?

    init(bFriend: BFriend? = nil) {
        self.bFriend = bFriend
        if let bFriend = bFriend {
            _name = State(initialValue: bFriend.name ?? "")
            _profileImage = State(initialValue: bFriend.profileImage)
            _dateOfBday = State(initialValue: bFriend.birth ?? Date())
            _notiFrequency = State(initialValue: bFriend.noti ?? [""])
            _relationshipTag = State(initialValue: bFriend.tags ?? [""])
        }
    }

    @Environment(\.dismiss) var dismiss

    @State private var imageData: Data?

    static let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY. M. d"
        return formatter
    }()

    var body: some View {
        NavigationView {
            VStack {
                HeaderForSaveBdayView(name: $name, dateOfBday: $dateOfBday, isLunar: $isLunar, notiFrequency: $notiFrequency, imageData: $imageData, relationshipTag: $relationshipTag, profilrImage: $profileImage)
                
                Spacer(minLength: 26)
                
                PhotoPickerForSaveBdayView(imageData: $imageData, selectedItem: $selectedItem)
                
                Spacer(minLength: 47)
                
                SetNameForSaveBdayView(name: $name)
                
                Spacer(minLength: 27.5)
                
                SetBirthForSaveBdayView(isLunar: $isLunar, dateOfBday: $dateOfBday, isshowingSheetForSettingDate: $isshowingSheetForSettingDate)
                
                Spacer(minLength: 29)
                
                
                ShowingBTagOfSaveBdayView(bTags: bTags, relationshipTag: $relationshipTag, isshowingSheetForCreatingTag: $isshowingSheetForCreatingTag)
                
                Spacer(minLength: 28)
                
                SetAlarmInSaveBdayView(notiFrequency: $notiFrequency)
                
                Spacer()
            }
        }
        .onAppear {
            // Optionally initialize additional state when view appears
            if let bFriend = bFriend {
                self.name = bFriend.name ?? ""
                self.profileImage = bFriend.profileImage
                self.dateOfBday = bFriend.birth ?? Date()
                self.notiFrequency = bFriend.noti ?? [""]
                self.relationshipTag = bFriend.tags ?? [""]
            }

        }
    }
}


#Preview {
    SaveBdayView()
}
