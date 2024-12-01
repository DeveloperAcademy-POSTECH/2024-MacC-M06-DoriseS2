//
//  PikaPikaCollageView.swift
//  BiRTH
//
//  Created by Hajin on 11/28/24.
//

import SwiftUI

struct PikaPikaCollageView: View {

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BPhotoForCollage.posX, ascending: true)],
        animation: .default
    ) private var photos: FetchedResults<BPhotoForCollage>

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink {
                    CollageByMyselfView()
                } label: {
                    Rectangle()
                }
            }
        }
    }
}

#Preview {
    PikaPikaCollageView()
}
