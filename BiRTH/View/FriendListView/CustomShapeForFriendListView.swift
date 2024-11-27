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
    func path (in rect: CGRect) -> Path {
        Path { path in
            // 시작점: 위쪽 가장자리 중간
            path.move(to: CGPoint(x: rect.size.width*4/9, y: 0))
            
            // 2
            path.addQuadCurve(to: CGPoint(x: rect.size.width, y: rect.size.height/2), control: CGPoint(x: rect.size.width*8/9, y: rect.size.height/10))
            
            // 3
            path.addQuadCurve(to: CGPoint(x: rect.size.width*4/9, y: rect.size.height), control: CGPoint(x: rect.size.width*8/9, y: rect.size.height*9/10))
            
            // 4
            path.addQuadCurve(to: CGPoint(x: 0, y: rect.size.height/2), control: CGPoint(x: rect.size.width/9, y: rect.size.height*9/10))
            
            path.addQuadCurve(to: CGPoint(x: rect.size.width*4/9, y: 0), control: CGPoint(x: rect.size.width/9, y: rect.size.height/10))
        }
    }
}
// MARK: CustomRectangle2
struct CustomRectangle2: Shape {
    func path (in rect: CGRect) -> Path {
        Path { path in
            // 시작점: 위쪽 가장자리 중간
            path.move(to: CGPoint(x: rect.size.width*13/20, y: 0))
            
            // 2
            path.addQuadCurve(to: CGPoint(x: rect.size.width, y: rect.size.height*13/20), control: CGPoint(x: rect.size.width*12/13, y: rect.size.height*2/40))
            
            // 3
            path.addQuadCurve(to: CGPoint(x: rect.size.width/2, y: rect.size.height), control: CGPoint(x: rect.size.width*8/9, y: rect.size.height*19/20))
            
            // 4
            path.addQuadCurve(to: CGPoint(x: 0, y: rect.size.height*3/5), control: CGPoint(x: rect.size.width*1/90, y: rect.size.height*19/20))
        
            path.addQuadCurve(to: CGPoint(x: rect.size.width*13/20, y: 0), control: CGPoint(x: rect.size.width/9, y: rect.size.height/15))
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
