import SwiftUI


struct TestSoyView: View {
    @State var pastedImages: [PastedImage] = []
    
    var body: some View {
        ZStack {
            EditMenuPresentView(pastedImages: $pastedImages)
            
            ForEach(pastedImages.indices, id: \.self) { index in
                GestureImageView(pastedImage: pastedImages[index], pastedImages: $pastedImages)
            }
        }
        
        ExportSafariButton()
    }
}


#Preview {
    TestSoyView()
}
