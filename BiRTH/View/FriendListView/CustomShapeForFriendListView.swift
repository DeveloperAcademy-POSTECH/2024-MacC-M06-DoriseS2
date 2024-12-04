//
//  CustomShapeForFriendListView.swift
//  BiRTH
//
//  Created by Cho YeonJi on 11/23/24.
//

import SwiftUI

struct CustomShapeForFriendListView: View {
    var body: some View {
        CustomRectangle2()
//        .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .topLeading, endPoint: .bottom))
        .frame(width: 200, height: 200)
    }
}

// MARK: CustomRectangle1
struct CustomRectangle1: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let width = rect.size.width
            let height = rect.size.height
            
            path.move(to: CGPoint(x: width * 0.4, y: 0))
            
            path.addCurve(
                to: CGPoint(x: width, y: height * 0.6),
                control1: CGPoint(x: width * 0.8, y: 0),
                control2: CGPoint(x: width, y: height * 0.3)
            )
            
            path.addCurve(
                to: CGPoint(x: width * 0.5, y: height),
                control1: CGPoint(x: width, y: height * 0.9),
                control2: CGPoint(x: width * 0.7, y: height)
            )
            
            path.addCurve(
                to: CGPoint(x: 0, y: height * 0.4),
                control1: CGPoint(x: width * 0.3, y: height),
                control2: CGPoint(x: 0, y: height * 0.7)
            )
            
            path.addCurve(
                to: CGPoint(x: width * 0.4, y: 0),
                control1: CGPoint(x: 0, y: height * 0.1),
                control2: CGPoint(x: width * 0.2, y: 0)
            )
        }
    }
}

// MARK: CustomRectangle2
struct CustomRectangle2: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let width = rect.size.width
            let height = rect.size.height
            
            path.move(to: CGPoint(x: width * 0.7, y: 0))
            
            path.addCurve(
                to: CGPoint(x: width, y: height * 0.7),
                control1: CGPoint(x: width * 0.9, y: 0),
                control2: CGPoint(x: width, y: height * 0.4)
            )
            
            path.addCurve(
                to: CGPoint(x: width * 0.4, y: height),
                control1: CGPoint(x: width, y: height * 0.9),
                control2: CGPoint(x: width * 0.7, y: height)
            )
            
            path.addCurve(
                to: CGPoint(x: 0, y: height * 0.5),
                control1: CGPoint(x: width * 0.1, y: height),
                control2: CGPoint(x: 0, y: height * 0.8)
            )
            
            path.addCurve(
                to: CGPoint(x: width * 0.7, y: 0),
                control1: CGPoint(x: 0, y: height * 0.2),
                control2: CGPoint(x: width * 0.5, y: 0)
            )
        }
    }
}

// MARK: CustomRectangle3
struct CustomRectangle3: Shape {
    func path (in rect: CGRect) -> Path {
        Path { path in
            // 시작점: 위쪽 가장자리 중간
            path.move(to: CGPoint(x: rect.size.width*13/20, y: 0))
            
            
        }
    }
}

#Preview {
    CustomShapeForFriendListView()
}
