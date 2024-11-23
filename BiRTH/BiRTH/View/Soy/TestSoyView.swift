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
        
        Text("60bold").font(.biRTH_bold_60)
        Text("hello").font(.biRTH_plusMark)
        Text("semi").font(.biRTH_semibold_16)
                          Text("semibig").font(.biRTH_semibold_20)

        
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
