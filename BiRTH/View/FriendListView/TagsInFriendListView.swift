//
//  ChooseTagsInSaveBdayView.swift
//  BiRTH
//
//  Created by Hajin on 11/20/24.
//

import SwiftUI
import CoreData

struct TagsInFriendListView: View {
    
    var bTags: FetchedResults<BTag>
    
    @Binding var relationshipTag: [String]
    @Binding var isshowingSheetForCreatingTag: Bool
    
    var body: some View {
        ForEach(bTags) { relationship in
            Button {
                if let name = relationship.name {
                    if relationshipTag.contains(name) {
                        relationshipTag.removeAll { $0 == name }
                    } else {
                        relationshipTag.append(name)
                    }
                }
            } label: {
                ZStack {
                    if let name = relationship.name {
                        Text(name)
                            .font(.biRTH_semibold_14)
                            .foregroundColor(.black)
                            .padding(.horizontal, 11)
                            .padding(.vertical, 8)
                            .frame(height: 48)
                            .background(
                                    RoundedRectangle(cornerRadius: 90)
                                        .fill(Color.white)
                                )
                            .overlay(
                                RoundedRectangle(cornerRadius: 90)
                                    .strokeBorder(Color.init(hex: relationship.color ?? "#000000"))
                            )
                        
                        if relationshipTag.contains(name) {
                            Text(name)
                                .font(.biRTH_semibold_14)
                                .foregroundColor(.clear)
                                .padding(.horizontal, 11)
                                .padding(.vertical, 8)
                                .frame(height: 48)
                                .background(.black)
                                .cornerRadius(20)
                                .opacity(0.15)
                            
                            Image(systemName: "checkmark")
                                .font(.system(size: 14.5, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
    }
}
