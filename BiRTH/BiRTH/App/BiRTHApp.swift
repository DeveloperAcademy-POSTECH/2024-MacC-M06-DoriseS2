//
//  BiRTHApp.swift
//  BiRTH
//
//  Created by chanu on 11/15/24.
//

import SwiftUI

@main
struct BiRTHApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var colorManager = ColorManager()

    var body: some Scene {
        WindowGroup {
//            CollageByMyselfView()
            TempFriendDetailView()
                .environmentObject(colorManager)

//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//            SaveBdayView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)

//            PhotoPickerAndListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)

        }
    }
}
