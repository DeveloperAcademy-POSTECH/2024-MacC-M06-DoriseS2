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
    @Environment(\.dismiss) var dismiss
  
    // State variables for user inputs
    @State private var name = ""
    @State private var profileImage: Data?
    @State private var dateOfBday: Date = Date()
    @State private var notiFrequency = [""]
    @State private var relationshipTag = [""]

    @State private var imageData: Data?
    @State private var selectedItem: PhotosPickerItem?
    @State private var isshowingSheetForSettingDate = false
    @State private var isshowingSheetForCreatingTag = false
    
    @State private var isEditing = false
    
    // Fetched results for tags
    @FetchRequest(
        entity: BTag.entity(),
        sortDescriptors: []
    )
    private var bTags: FetchedResults<BTag>
    
    var bFriend: BFriend? = nil

    
    static let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY. M. d"
        return formatter
    }()
    
    var body: some View {
        VStack {
//            HeaderForSaveBdayView(viewContext: $isEditing, context: bFriend, dismiss: $name, bFriend: $dateOfBday, name: $notiFrequency, dateOfBday: $imageData, notiFrequency: $relationshipTag, imageData: $profileImage)
            
            HeaderForSaveBdayView(bFriend: bFriend, name: $name, dateOfBday: $dateOfBday, notiFrequency: $notiFrequency, imageData: $imageData, profileImage: $profileImage, relationshipTag: $relationshipTag, isEditing: $isEditing)
            
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
        .navigationBarBackButtonHidden(true)
        .onAppear {
                if let bFriend = bFriend {
                    print("bFriend exists with ID: \(bFriend.objectID)")
                    if let collage = bFriend.bCollage {
                        print("Collage exists with ID: \(collage.objectID)")
                    } else {
                        print("Collage is nil")
                    }
                } else {
                    print("bFriend is nil")
                }

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
