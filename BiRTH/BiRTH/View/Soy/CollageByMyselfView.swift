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
}
