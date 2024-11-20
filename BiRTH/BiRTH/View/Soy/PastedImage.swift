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
    var position: CGPoint
    var currentAmount: CGFloat = 0
    var lastAmount: CGFloat = 0
    var scale: CGFloat = 1.0
    var angle: Angle = .init(degrees: 0)
    var dragOffset: CGSize = .zero
    var accumulatedOffset: CGSize = .zero
}
