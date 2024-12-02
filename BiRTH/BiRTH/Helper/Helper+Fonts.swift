//
//  Untitled.swift
//  BiRTH
//
//  Created by chanu on 11/23/24.
//

import Foundation
import SwiftUI

enum Pretendard: String {
    case black = "Pretendard-Black"
    case bold = "Pretendard-Bold"
    case extraBold = "Pretendard-ExtraBold"
    case extraLight = "Pretendard-ExtraLight"
    case light = "Pretendard-Light"
    case medium = "Pretendard-Medium"
    case regular = "Pretendard-Regular"
    case semiBold = "Pretendard-SemiBold"
    case thin = "Pretendard-Thin"
    case plusButton = "Shantell Sans"
}

extension Font {
    // MARK: - Bold
    static let biRTH_bold_12 = Font.custom("Pretendard-Bold", size: 12)
    static let biRTH_bold_14 = Font.custom("Pretendard-Bold", size: 14)
    static let biRTH_bold_16 = Font.custom("Pretendard-Bold", size: 16)
    static let biRTH_bold_18 = Font.custom("Pretendard-Bold", size: 18)
    static let biRTH_bold_24 = Font.custom("Pretendard-Bold", size: 24)
    static let biRTH_bold_28 = Font.custom("Pretendard-Bold", size: 28)
    static let biRTH_bold_36 = Font.custom("Pretendard-Bold", size: 36)
    static let biRTH_bold_60 = Font.custom("Pretendard-Bold", size: 60)
    
    // MARK: - SemiBold
    static let biRTH_semibold_14 = Font.custom("Pretendard-SemiBold", size: 14)
    static let biRTH_semibold_16 = Font.custom("Pretendard-SemiBold", size: 16)
    static let biRTH_semibold_18 = Font.custom("Pretendard-SemiBold", size: 18)
    static let biRTH_semibold_20 = Font.custom("Pretendard-SemiBold", size: 20)
    
    // MARK: - Regular
    static let biRTH_regular_12 = Font.custom("Pretendard-Regular", size: 12)
    static let biRTH_regular_14 = Font.custom("Pretendard-Regular", size: 14)
    static let biRTH_regular_18 = Font.custom("Pretendard-Regular", size: 18)
    static let biRTH_regular_22 = Font.custom("Pretendard-Regular", size: 22)
    static let biRTH_regular_24 = Font.custom("Pretendard-Regular", size: 24)
    static let biRTH_regular_28 = Font.custom("Pretendard-Regular", size: 28)
    static let biRTH_regular_32 = Font.custom("Pretendard-Regular", size: 32)
    
    // MARK: - PLUS MARK
    static let biRTH_plusMark = Font.custom("Shantell Sans", size: 32).weight(.heavy)
}
