

import SwiftUI
import UIKit


struct CustomSheet: View {
    let rows = [GridItem(.flexible())]
    @Environment(\.dismiss) var dismiss
    
    
    @Binding var selectedImage: UIImage
    @Binding var pastedImages: [PastedImage]
    @Binding var selectedImageID: UUID?

    
    
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal) {
                HStack {
                    RemoveBackgroundButton(image: $selectedImage)
                    DeleteButton(pastedImages: $pastedImages, selectedImageID: $selectedImageID)
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    XmarkButton()
                }
            }
        }
    }
}





//#Preview {
//    CustomSheet(selectedImage: <#T##UIImage#>, sheetHeight: <#T##CGFloat#>, isCustomSheet: <#T##Bool#>, pastedImages: <#T##[PastedImage]#>, selectedImageID: <#T##UUID?#>)
//}
