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
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}



