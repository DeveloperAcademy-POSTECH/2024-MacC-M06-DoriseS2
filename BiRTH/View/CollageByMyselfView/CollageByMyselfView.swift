import SwiftUI


struct CollageByMyselfView: View {
    @State var pastedImages: [PastedImage] = []
    @State var selectedImageID: UUID? = nil
    @State var isCustomSheet: Bool = false
    @State var sheetHeight: CGFloat = UIScreen.main.bounds.height * 0.2
    
    var body: some View {
        ZStack {
            // BackgroundColor
            Color.biRTH_mainColor.ignoresSafeArea()
            
            VStack {
                ColByMyselfTopView(friendImage: "exampleImage", friendName: "임찬우", remainDday: 5)
                
                ZStack {
                    EditMenuPresentView(pastedImages: $pastedImages)
                    
                    ForEach(pastedImages.indices, id: \.self) { index in
                        GestureImageView(
                            pastedImage: pastedImages[index],
                            pastedImages: $pastedImages,
                            selectedImageID: $selectedImageID,
                            isCustomSheet: $isCustomSheet,
                            sheetHeight: $sheetHeight
                        )
                    }
                }
                
                ColByMyselfBottomView(selectedPhotos: $pastedImages)

            }
            
            if isCustomSheet {
                if let selectedIndex = pastedImages.firstIndex(where: { $0.id == selectedImageID }) {
                    CustomSheet(
                        image: $pastedImages[selectedIndex].pastedImage,
                        sheetHeight: $sheetHeight,
                        isCustomSheet: $isCustomSheet
                    )
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut(duration: 0.5), value: isCustomSheet)
                }
            }
                
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton()
            }
            
            
            ToolbarItem(placement: .topBarTrailing) {
                RedoUndo()
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Rectangle()
                    .frame(width: 16)
                    .foregroundStyle(.clear)
            }
  
            ToolbarItem(placement: .topBarTrailing) {
                SendAndShare()
            }
            
        }
    }
}



#Preview {
    CollageByMyselfView()
        .environmentObject(ColorManager())
}
