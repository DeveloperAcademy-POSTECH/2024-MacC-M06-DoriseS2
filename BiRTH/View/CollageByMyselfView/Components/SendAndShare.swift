//
//  SendAndShare.swift
//  BiRTH
//
//  Created by 이소현 on 11/25/24.
//

//import SwiftUI
//import Photos
//
//
//// TODO: EditMenuPresent 만큼만 캡쳐될 수 있도록 수정하기
//struct SendAndShare: View {
//    @State private var showingAlert: Bool = false
////    let view: any View
//    
//    
//    var body: some View {
//        Button {
//            showingAlert = true
////            captureAndSaveView(of: view)
//            print("paperplane")
//        } label: {
//            Image(systemName: "paperplane")
//                .foregroundStyle(.black)
//        }
//        .alert(isPresented: $showingAlert) {
//            let firstButton = Alert.Button.cancel(Text("완료")) {
//                screenShot()
//                print("secondary button pressed")
//            }
//            let secondButton = Alert.Button.default(Text("공유하기")) {
//                share()
//            }
//            
//            return Alert(title: Text("저장하기"),
//                         message: Text("이미지를 저장합니다."),
//                         primaryButton: firstButton, secondaryButton: secondButton)
//        }
//    }
//}


//#Preview {
//    SendAndShare()
//}
