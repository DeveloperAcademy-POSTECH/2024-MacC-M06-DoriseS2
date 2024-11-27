//
//  PhotoPickerForSaveBdayView.swift
//  BiRTH
//
//  Created by Hajin on 11/20/24.
//

import SwiftUI
import PhotosUI

struct PhotoPickerForSaveBdayView: View {

    @Binding var imageData: Data?
    @Binding var selectedItem: PhotosPickerItem?

    var body: some View {
        //MARK: 이미지 피커
        ZStack {
            PhotosPicker(selection: $selectedItem, matching: .images) {
                if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 45))
                        .frame(width: 112, height: 112)
                } else {
                    ZStack {
                        Image("basicprofile")
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 45))
                            .frame(width: 112, height: 112)
                    }
                }
            }
            .onChange(of: selectedItem) { oldItem, newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        imageData = data
                    }
                }
            }

            Image("photologo")
                .resizable()
                .clipShape(Circle())
                .frame(width: 30, height: 30)
                .offset(x: 30, y: 40)
        }
    }
}
