//
//  Helper+Color.swift
//  BiRTH
//
//  Created by Hajin on 11/16/24.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}

extension Color {
    static let biRTH_mainColor = Color(hex: "FFF5EE") // 배경화면컬러(연한베이지)
    static let biRTH_pointColor = Color(hex: "B35588") // 포인트컬러(분홍)
    static let biRTH_text1 = Color(hex: "AEAEAE") // 텍스트컬러1(연그레이)
    static let biRTH_text2 = Color(hex: "6B6B6B") // 텍스트컬러2(진한그레이)
    
}
