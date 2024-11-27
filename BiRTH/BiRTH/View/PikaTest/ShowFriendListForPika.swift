//
//  ShowFriendListForPika.swift
//  BiRTH
//
//  Created by Hajin on 11/27/24.
//

import SwiftUI
import PhotosUI

struct ShowFriendListForPika: View {

    @FetchRequest(
        entity: BFriend.entity(),
        sortDescriptors: []
    )
    private var bFriend: FetchedResults<BFriend>

    @Environment(\.managedObjectContext) private var viewContext


    var body: some View {
        NavigationView{
            VStack {
                NavigationLink {

                    SaveBdayView()

                } label: {
                    Rectangle()
                }
                List {
                    ForEach(bFriend) { bFriend in
                        VStack {
                            NavigationLink {
                                SaveBdayView(bFriend: bFriend)
                            } label: {
                                Text(bFriend.name ?? "")
                            }
                           
                            Button{
                                viewContext.delete(bFriend)
                                saveData(viewContext: viewContext)
                            }label: {
                                Text("Delete")
                            }
                        }

                    }
                }
            }
        }
    }
}

//#Preview {
//    ShowFriendListForPika()
//}
