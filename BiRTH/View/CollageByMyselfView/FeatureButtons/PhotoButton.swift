//
//  PhotoButton.swift
//  BiRTH
//
//  Created by 이소현 on 11/27/24.
//

import SwiftUI
import PhotosUI

struct PhotoButton: View {
    @State var showingPhotoPicker = false
    @State var selectedItem: UIImage? = nil
    
    var body: some View {
        Button {
            showingPhotoPicker.toggle()
            print("PhotoButton")
        } label: {
            FeatureCircle(colorHex: "FFF100", featureImgName: "photo", featureName: "사진")
        }
        
    }
}

struct PhotoPickerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedItem: UIImage?
    
    var body: some View {
        PhotosPicker(
            "", selection: Binding(get: { nil }, set: { newSelection in
                Task {
                    if let imageData = try? await newSelection?.loadTransferable(type: Data.self),
                       let image = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            selectedItem = image
                        }
                    }
                    dismiss() // 선택 후 PhotoPicker 닫기
                }
            }),
            matching: .images,
            photoLibrary: .shared()
        )
    }
}


#Preview {
    PhotoButton()
}
