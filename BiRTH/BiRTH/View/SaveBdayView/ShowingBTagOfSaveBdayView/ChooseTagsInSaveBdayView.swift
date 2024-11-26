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
#Preview {
    struct PreviewContainer: View {
        @FetchRequest(
            entity: BTag.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \BTag.name, ascending: true)]
        ) private var bTags: FetchedResults<BTag>
        
        var body: some View {
            ScrollView(.horizontal) {
                HStack {
                    ChooseTagsInSaveBdayView(
                        bTags: bTags,
                        relationshipTag: .constant([]),
                        isshowingSheetForCreatingTag: .constant(false)
                    )
                }
            }
        }
    }
    
    // Core Data 컨텍스트 생성
    let context = PersistenceController.preview.container.viewContext
    
    // 테스트용 태그 데이터 생성
    let tag1 = BTag(context: context)
    tag1.id = UUID()
    tag1.name = "친구"
    tag1.color = "#FFB6C1"
    
    let tag2 = BTag(context: context)
    tag2.id = UUID()
    tag2.name = "애플 디벨로퍼 아카데미"
    tag2.color = "#98FB98"
    
    try? context.save()
    
    return PreviewContainer()
        .environment(\.managedObjectContext, context)
}
