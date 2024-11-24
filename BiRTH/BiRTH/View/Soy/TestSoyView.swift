import SwiftUI


struct TestSoyView: View {
    @State var pastedImages: [PastedImage] = []
    @State var selectedImageID: UUID? = nil
    @State var showingButtonSheet = false
    @EnvironmentObject var colorManager: ColorManager
    
    var body: some View {
        ZStack {
            EditMenuPresentView(pastedImages: $pastedImages)
            
            ForEach(pastedImages.indices, id: \.self) { index in
                GestureImageView(pastedImage: pastedImages[index], pastedImages: $pastedImages, selectedImageID: $selectedImageID)
            }
        }
        
        Button {
            showingButtonSheet.toggle()
        } label: {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 40))
        }
        .sheet(isPresented: $showingButtonSheet) {
            ButtonSheet()
                .environmentObject(colorManager)
                .presentationDetents([.fraction(0.25)])
        }
    }
}


#Preview {
    TestSoyView()
}
