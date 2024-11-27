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
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .frame(width: 166, height: 168)
                } else {
                    ZStack {
                        Image("photo")
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .frame(width: 166, height: 168)
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
            
            PhotosPicker(
                selection: $selectedItem,
                matching: .images
            ) {
                Image("AddButton")
                    .resizable()
                    .frame(width: 46, height: 47)
                    .padding(.leading, 123)
                    .padding(.top, 128)
            }
        }
    }
}

#Preview {
    PhotoPickerForSaveBdayView(
        imageData: .constant(nil),
        selectedItem: .constant(nil)
    )
}

