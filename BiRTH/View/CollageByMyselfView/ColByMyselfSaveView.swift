//
//  ColByMyselfSaveView.swift
//  BiRTH
//
//  Created by Hajin on 11/28/24.
//

import SwiftUI

struct ColByMyselfSaveView: View {
    var body: some View {
        HStack {
            Spacer()

            Image(systemName: "arrow.uturn.left")
                .font(.title)
                .foregroundColor(.black)

            Image(systemName: "arrow.uturn.right")
                .font(.title)
                .foregroundColor(.black)

            Text("임시저장")
                .font(.title)
                .foregroundColor(.black)
                .padding()
        }
    }
}

#Preview {
    ColByMyselfSaveView()
}
