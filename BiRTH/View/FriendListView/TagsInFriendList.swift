//
//  Temp_TagsInFriendList.swift
//  BiRTH
//
//  Created by 이소현 on 11/29/24.
//

import SwiftUI

// MARK: - TagsInFriendListView
struct TagsInFriendList: View {
    
    var bTags: FetchedResults<BTag>
    @Binding var tagName: [String]
    @Binding var tagColor: [String]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(bTags) { bTag in
                    Button {
                        if let name = bTag.name, let color = bTag.color {
                            if tagName.contains(name), tagColor.contains(color) {
                                tagName.removeAll { $0 == name }
                                tagColor.removeAll { $0 == color}
                            } else {
                                tagName.append(name)
                                tagColor.append(color)
                            }
                            print(name)
                            print(color)
                        }
                        
                    } label: {
                        ZStack {
                            if let name = bTag.name, let color = bTag.color {
                                Text(name)
                                    .modifier(BaseTagViewModfier(bTagColor: bTag.color ?? "#000000"))
                                
                                
                                // Tag가 선택된 경우
                                if tagName.contains(name), tagColor.contains(color) {
                                    Text(name)
                                        .modifier(clickedTagViewModfier())
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


// MARK: - ViewModifier
struct BaseTagViewModfier: ViewModifier {
    var bTagColor: String
    
    func body(content: Content) -> some View {
        content
            .font(.biRTH_semibold_14)
            .foregroundColor(.black)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .frame(height: 40)
            .background(
                RoundedRectangle(cornerRadius: 90)
                    .fill(Color.white)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 90)
                    .strokeBorder(Color.init(hex: bTagColor))
            )
        
    }
}

struct clickedTagViewModfier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.biRTH_semibold_14)
            .foregroundColor(.clear)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .frame(height: 40)
            .background(.black)
            .cornerRadius(20)
            .opacity(0.15)
        
        Image(systemName: "checkmark")
            .font(.system(size: 14.5, weight: .bold))
            .foregroundColor(.white)
    }
}
