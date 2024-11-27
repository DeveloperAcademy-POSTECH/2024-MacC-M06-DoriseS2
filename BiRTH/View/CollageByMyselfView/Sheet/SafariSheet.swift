//
//  SafariSheet.swift
//  BiRTH
//
//  Created by 이소현 on 11/18/24.
//

import SwiftUI
import SafariServices


struct SafariSheet: UIViewControllerRepresentable {

    let url: URL
    
    /// Inherited from UIViewControllerRepresentable.makeUIViewController(context:).
    /// safari 브라우저를 생성합니다. 
    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}



