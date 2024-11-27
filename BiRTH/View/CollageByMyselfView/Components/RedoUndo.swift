//
//  RedoUndo.swift
//  BiRTH
//
//  Created by 이소현 on 11/25/24.
//

import SwiftUI

struct RedoUndo: View {
    var body: some View {
        HStack(spacing: 4) {
            Button {
                print("arrow.uturn.left")
            } label: {
                Image(systemName: "arrow.uturn.left")
                    .foregroundStyle(.black)
            }
            
            Button {
                print("arrow.uturn.forward")
            } label: {
                Image(systemName: "arrow.uturn.forward")
                    .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    RedoUndo()
}
