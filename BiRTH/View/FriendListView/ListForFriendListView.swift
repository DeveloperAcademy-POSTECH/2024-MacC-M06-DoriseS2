//
//  ListForFriendListView.swift
//  BiRTH
//
//  Created by Cho YeonJi on 11/25/24.
//

import SwiftUI
import CoreData

struct ListForFriendListView: View {

    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(entity: BFriend.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \BFriend.birth, ascending: true)])
    var bFriend: FetchedResults<BFriend>
    
//    let ddayUtils = DdayUtils()

    var body: some View {
        List(bFriend, id: \.self) { friend in
            NavigationLink {
                SaveBdayView(bFriend: friend)
            } label: {
            HStack {
                Group {
                    if let imageData = friend.profileImage,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 45, height: 45)
                            .clipShape(.circle)
                    } else {
                        Image("photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 45, height: 45)
                            .clipShape(.circle)
                    }
                }
                .padding(.leading, 21)
                .padding(.trailing, 15)

                Text(friend.name ?? "")
                    .font(.biRTH_semibold_14)
                    .foregroundColor(.black)

                Spacer()
                
                if let birthDate = friend.birth {
//                    Text("\(ddayUtils.calculateDday(birth: birthDate))")
//                        .font(.biRTH_bold_12)
//                        .foregroundColor(.biRTH_text1)
//                        .padding(.trailing, 10)
                }
            } //: HSTACK
        }
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                Button {
                    viewContext.delete(friend)
                    saveData(viewContext: viewContext)
                } label: {
                    Label("Delete", systemImage: "minus.circle.fill")
                        .symbolRenderingMode(.palette)
                        .background(Color.red)
                }
                .tint(.biRTH_mainColor)
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.biRTH_mainColor)
        } //: List
        .listStyle(.plain)
        .background(Color.biRTH_mainColor)
    }
}
