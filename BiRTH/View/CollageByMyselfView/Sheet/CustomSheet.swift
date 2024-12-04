

import SwiftUI
import UIKit


struct CustomSheet: View {
    let rows = [GridItem(.flexible())]
    @Environment(\.dismiss) var dismiss
    
    //    @Binding var isCustomSheet: Bool
    @Binding var selectedImage: UIImage
    @Binding var pastedImages: [PastedImage]
    @Binding var selectedImageID: UUID?
    @Binding var isCustomSheet: Bool
    
    
    
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal) {
                HStack(spacing: 24) {
                    RemoveBackgroundButton(
                        image: $selectedImage,
                        pastedImages: $pastedImages,
                        selectedImageID: $selectedImageID
                    )
                    DeleteButton(pastedImages: $pastedImages, selectedImageID: $selectedImageID)
                    
                    Text("HI")
                        .foregroundStyle(.black)
                }
                .padding()
                
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        selectedImageID = nil
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")
                            .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}





//#Preview {
//    CustomSheet(selectedImage: <#T##UIImage#>, sheetHeight: <#T##CGFloat#>, isCustomSheet: <#T##Bool#>, pastedImages: <#T##[PastedImage]#>, selectedImageID: <#T##UUID?#>)
//}
