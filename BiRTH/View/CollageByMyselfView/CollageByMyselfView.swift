import SwiftUI


struct CollageByMyselfView: View {
    @EnvironmentObject var colorManager: ColorManager
    
    @State var pastedImages: [PastedImage] = []
    @State var selectedImageID: UUID? = nil
    @State var isCustomSheet: Bool = false
    @State var sheetHeight: CGFloat = UIScreen.main.bounds.height * 0.2
    
    let rows = [GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            // BackgroundColor
            Color.biRTH_mainColor.ignoresSafeArea()
            
            
            VStack {
                ColByMyselfTopView(friendImage: "exampleImage", friendName: "임찬우", remainDday: 5)
                
//                ZStack {
//                    EditMenuPresentView(pastedImages: $pastedImages)
//                    
//                    ForEach(pastedImages.indices, id: \.self) { index in
//                        GestureImageView(
//                            pastedImage: pastedImages[index],
//                            pastedImages: $pastedImages,
//                            selectedImageID: $selectedImageID,
//                            isCustomSheet: $isCustomSheet,
//                            sheetHeight: $sheetHeight
//                        )
//                    }
//                    
//                }
                imageField
                
                ColByMyselfBottomView(selectedPhotos: $pastedImages)
                
            }
            
            if isCustomSheet {
                if let selectedIndex = pastedImages.firstIndex(where: { $0.id == selectedImageID }) {
                    
                    ZStack(alignment: .bottom) {
                        EmptyView()
                            .opacity(0)
                            .ignoresSafeArea()
                        
                        ZStack(alignment: .topLeading) {
                            ScrollView(.horizontal) {
                                HStack(spacing: 24) {
                                    RemoveBackgroundButton(image: $pastedImages[selectedIndex].pastedImage)
                                    DeleteButton()
                                }
                                .padding()
                                Spacer()
                            }
                            
                            HStack {
                                Spacer()
                                Button {
                                    isCustomSheet = false
                                    selectedImageID = nil
                                    
                                } label: {
                                    Image(systemName: "xmark.circle")
                                        .foregroundStyle(.black)
                                        .font(.system(size: 24))
                                }
                                .padding(.vertical)
                                .padding(.horizontal, 14)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(maxHeight: sheetHeight)
                        .background(.white)
                        .cornerRadius(16, corners: .topLeft)
                        .cornerRadius(16, corners: .topRight)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .ignoresSafeArea()
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
                SendAndShare(view: imageField)
            }
            
        }
    }
}

private extension CollageByMyselfView {
    var imageField: some View {
        
        ZStack {
            EditMenuPresentView(pastedImages: $pastedImages)
                .environmentObject(colorManager)
            
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
    }
}

#Preview {
    CollageByMyselfView()
        .environmentObject(ColorManager())
}
