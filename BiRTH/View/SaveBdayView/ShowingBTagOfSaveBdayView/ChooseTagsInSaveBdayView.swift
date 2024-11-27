//
//  ChooseTagsInSaveBdayView.swift
//  BiRTH
//
//  Created by Hajin on 11/20/24.
//

import SwiftUI
import CoreData

struct ChooseTagsInSaveBdayView: View {

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
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.black)
                                .padding()
                                .frame(height: 43)
                                .background(Color.init(hex: relationship.color ??  "#000000"))
                                .cornerRadius(40)

                            if relationshipTag.contains(name) {
                                Text(name)
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.clear)
                                    .padding()
                                    .frame(height: 43)
                                    .background(.black)
                                    .cornerRadius(40)
                                    .opacity(0.3)

                                Image(systemName: "checkmark")
                                    .font(.system(size: 14.5, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }

                    
                }
            }
//            ForEach(bTags, id:\.id) {relationship in
//                Button {
//                    if relationshipTag.contains(relationship.tagName) {
//                        relationshipTag.removeAll { $0 == relationship.tagName }
//                    } else {
//                        relationshipTag.append(relationship.tagName)
//                    }
//                } label: {
//                    ZStack {
//                        Text(relationship.tagName)
//                        //                        .font(.system(size: 15, weight: .bold))
//                        //                        .foregroundColor(.black)
//                        //                        .padding()
//                        //                        .frame(height: 43)
//                        //                        .background(Color.init(hex: relationship.tagColor))
//                        //                        .cornerRadius(40)
//
//                        if relationshipTag.contains(relationship.tagName) {
//                            Text(relationship.tagName)
//                                .font(.system(size: 15, weight: .bold))
//                                .foregroundColor(.clear)
//                                .padding()
//                                .frame(height: 43)
//                                .background(.black)
//                                .cornerRadius(40)
//                                .opacity(0.3)
//
//                            Image(systemName: "checkmark")
//                                .font(.system(size: 14.5, weight: .bold))
//                                .foregroundColor(.white)
//                        }
//                    }
//                }
//            }
        }
    }
}
