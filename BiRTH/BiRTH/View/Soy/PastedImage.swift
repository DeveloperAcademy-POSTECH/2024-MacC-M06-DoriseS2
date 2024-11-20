//
//  PastedImage.swift
//  BiRTH
//
//  Created by 이소현 on 11/19/24.
//

import SwiftUI

struct PastedImage: Identifiable {
    let id = UUID()
    var image: UIImage
    var position: CGPoint = .zero
    var accumulatedOffset: CGSize = .zero
    var dragOffset: CGSize = .zero
    var scale: CGFloat = 1.0
    var currentAmount: CGFloat = 0
    var lastAmount: CGFloat = 0
    var angle: Angle = .zero
    var currentAngle: CGFloat = 0 // 현재 회전 각도
    var lastAngle: CGFloat = 0    // 누적 회전 각도
}
