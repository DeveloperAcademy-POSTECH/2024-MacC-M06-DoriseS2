//
//  PastedImages.swift
//  BiRTH
//
//  Created by 이소현 on 11/20/24.
//

import Foundation
import SwiftUI

class PastedImage: ObservableObject, Identifiable {
    let id = UUID()
    
    @Published var imageWidth: CGFloat = 0
    @Published var imageHeight: CGFloat = 0
    @Published var imagePosition = CGPoint(x: 0, y: 0)
    
    @Published var angle: Angle = .zero
    @Published var angleSum: Double = 0
    
    var pastedImage: UIImage
    
    var rotateDotPosition: CGPoint {
        calcHandlePostion(offsetX: imageWidth / 2, offsetY: imageHeight / 2)
    }
    
    init(imageWidth: CGFloat, imageHeight: CGFloat, imagePosition: CGPoint, angle: Angle, angleSum: Double, pastedImage: UIImage) {
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        self.imagePosition = imagePosition
        self.angle = angle
        self.angleSum = angleSum
        self.pastedImage = pastedImage
    }
    
    /// rotateDotPosition이 이미지를 기준으로 오른쪽 상단에 배치될 수 있도록 하는 함수입니다.
    func calcHandlePostion(offsetX: CGFloat, offsetY: CGFloat) -> CGPoint {
        let angleInRadians = angleSum / 180 * Double.pi
        
        return CGPoint(
            x: cos(angleInRadians) * offsetX - sin(angleInRadians) * offsetY + imagePosition.x,
            y: sin(angleInRadians) * offsetX + cos(angleInRadians) * offsetY + imagePosition.y
        )
    }
    
    // Hashable과 Equatable을 준수하기 위한 메소드입니다.
    // 동일한 id를 가진 객체는 동일한 것으로 간주됩니다.
    /// Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    /// Equatable
    static func == (lhs: PastedImage, rhs: PastedImage) -> Bool {
        lhs.id == rhs.id
    }
    
}
