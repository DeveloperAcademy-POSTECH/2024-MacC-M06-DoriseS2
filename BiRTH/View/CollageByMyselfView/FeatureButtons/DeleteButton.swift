//
//  DeleteButton.swift
//  BiRTH
//
//  Created by 이소현 on 11/26/24.
//

import SwiftUI

struct DeleteButton: View {
    @Binding var pastedImages: [PastedImage]
    @Binding var selectedImageID: UUID?
    @Binding var isCustomSheet: Bool

    var body: some View {
        Button {
            print("Delete Button")
            deleteSelectedImage()
            isCustomSheet = false
        } label: {
            FeatureCircle(colorHex: "F96E2A", featureImgName: "trash", featureName: "사진삭제")
        }
    }

    /// 선택된 이미지를 삭제하는 함수입니다.
        private func deleteSelectedImage() {
            guard let id = selectedImageID else { return }
            if let index = pastedImages.firstIndex(where: { $0.id == id }) {
                pastedImages.remove(at: index)
                selectedImageID = nil // 선택 상태 초기화
            }
        }
}

//#Preview {
//    DeleteButton()
//}
