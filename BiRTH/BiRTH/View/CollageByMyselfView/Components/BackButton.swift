//
//  BackButton.swift
//  BiRTH
//
//  Created by 이소현 on 11/25/24.
//

import SwiftUI

struct BackButton: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    BackButton()
}
