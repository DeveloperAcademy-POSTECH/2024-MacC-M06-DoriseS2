//
//  SendAndShare.swift
//  BiRTH
//
//  Created by 이소현 on 11/25/24.
//

import SwiftUI

struct SendAndShare: View {
    var body: some View {
        Button {
            print("paperplane")
        } label: {
            Image(systemName: "paperplane")
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    SendAndShare()
}
