import SwiftUI


struct CollageByMyselfView: View {
    @State var pastedImages: [PastedImage] = []
    @State var selectedImageID: UUID? = nil
    
    var body: some View {
        ZStack {
            // BackgroundColor
            Color.biRTH_mainColor.ignoresSafeArea()
            
            VStack {
                ColByMyselfTopView(friendImage: "exampleImage", friendName: "임찬우", remainDday: 5)
                
                ZStack {
                    EditMenuPresentView(pastedImages: $pastedImages)
                    
                    ForEach(pastedImages.indices, id: \.self) { index in
                        GestureImageView(pastedImage: pastedImages[index], pastedImages: $pastedImages, selectedImageID: $selectedImageID)
                    }
                }
                
                ColByMyselfBottomView()
            }
        }
    }
}


struct ColByMyselfBottomView: View {
    @EnvironmentObject var colorManager: ColorManager
    @State var showingButtonSheet = false
    
    var body: some View {
        Button {
            showingButtonSheet.toggle()
        } label: {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 40))
                .foregroundStyle(Color.biRTH_pointColor)
        }
        .padding(.vertical, 5)
        .sheet(isPresented: $showingButtonSheet) {
            ButtonSheet()
                .environmentObject(colorManager)
                .presentationDetents([.fraction(0.25)])
        }
    }
}


#Preview {
    CollageByMyselfView()
}
