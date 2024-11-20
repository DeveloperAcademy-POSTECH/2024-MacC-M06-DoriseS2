//
//  Extension+TestSoyView.swift
//  BiRTH
//
//  Created by 이소현 on 11/19/24.
//

import SwiftUI

extension TestSoyView {
    
    func dragGesture(index: Int) -> some Gesture {
        DragGesture()
            .onChanged { value in
                pastedImages[index].dragOffset = pastedImages[index].accumulatedOffset + value.translation
            }
            .onEnded { value in
                withAnimation(.smooth) {
                    pastedImages[index].accumulatedOffset = pastedImages[index].accumulatedOffset + value.translation
                }
            }

    }
    
    func magnificationGesture(index: Int) -> some Gesture {
        MagnificationGesture()
            .onChanged { value in
                pastedImages[index].currentAmount = value - 1
            }
        
            .onEnded { value in
                pastedImages[index].lastAmount += pastedImages[index].currentAmount
                pastedImages[index].currentAmount = 0
            }
    }
    
    func rotateGesture(index: Int) -> some Gesture {
        RotateGesture()
            .onChanged { value in
                pastedImages[index].angle = value.rotation
            }
    }
}


extension CGSize {
    static func + (lhs: Self, rhs: Self) -> Self {
        CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
}
