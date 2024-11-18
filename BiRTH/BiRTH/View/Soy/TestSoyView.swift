//
//  TestView.swift
//  BiRTH
//
//  Created by 이소현 on 11/15/24.
//

import UIKit
import SwiftUI

struct TestSoyView: View {
    
    @State private var pastedImage: UIImage?
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            EditMenuPresentView(pastedImage: $pastedImage)
            
            VStack {
                if let pastedImage = pastedImage {
                    Image(uiImage: pastedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                } else {
                    Text("copy Image and paste")
                    //                    .frame(width: 500, height: 500)
                        .foregroundStyle(.gray)
                    
                }
                
                ExportSafariButton()
                
            }
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("오류"),
                  dismissButton: .default(Text("확인")))
            
        }
    }
}

extension TestSoyView {
    func pasteImageFromClipboard() {
        if let image = UIPasteboard.general.image {
            pastedImage = image
        } else {
            showAlert = true
        }
    }
}

#Preview {
    TestSoyView()
}
