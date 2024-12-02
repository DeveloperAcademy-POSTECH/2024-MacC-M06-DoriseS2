import SwiftUI
import CoreData

//최상위뷰
struct CollageByMyselfView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
//    var undoManager = UndoManager()

    
    @EnvironmentObject var colorManager: ColorManager
    

    var bFriend: BFriend? = nil
//    var bCollage: BCollage? = nil

    @Environment(\.scenePhase) private var scenePhase

    @State var pastedImages: [PastedImage] = []
    @State var selectedImageID: UUID? = nil
    @State var isCustomSheet: Bool = false
    @State var sheetHeight: CGFloat = UIScreen.main.bounds.height * 0.2
    
    let rows = [GridItem(.flexible())]

    @State private var collage: BCollage? = nil
    @Environment(\.dismiss) var dismiss

//    let collage: BCollage


    var body: some View {
        ZStack {
            // BackgroundColor
            Color.biRTH_mainColor.ignoresSafeArea()
            
            
            VStack {
//                ColByMyselfSaveView()
//                HStack(spacing: 0) {
//                    Spacer()
//
//                    Image(systemName: "arrow.uturn.left")
//                        .foregroundColor(.black)
//
//                    Image(systemName: "arrow.uturn.right")
//                        .foregroundColor(.black)
//
//                    
//                }.padding(0)

                ColByMyselfTopView(bFriend: bFriend!)
                
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
                                        .foregroundStyle(.white)
                                        .font(.system(size: 24))
                                }
                                .padding(.vertical)
                                .padding(.horizontal, 14)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(maxHeight: sheetHeight)
                        .background(.black)
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
            
//            ToolbarItem(placement: .topBarTrailing) {
//                Rectangle()
//                    .frame(width: 16)
//                    .foregroundStyle(.clear)
//            }
            
            ToolbarItem(placement: .topBarTrailing) {

                Button {
                    if let collage = collage {
                            savePastedImages2(to: collage, pastedImages: pastedImages, context: viewContext)
                        }
                    dismiss()
                } label: {
                    Text("임시저장")
                        .foregroundColor(.black)
                }
                
                //                SendAndShare(view: imageField)
            }
            
        }
        .onAppear {
//            loadData()
            // bFriend가 nil인지 확인
            guard let unwrappedFriend = bFriend else {
                print("Error: bFriend is nil")
                return
            }

            // Collage가 없는 경우 생성
            if unwrappedFriend.bCollage == nil {
                let newCollage = createAndAssignBCollage(for: unwrappedFriend, context: viewContext)
                collage = newCollage
                print("1")
            } else {
                collage = unwrappedFriend.bCollage
                print("2")
            }

            // PastedImages 로드
            if let collage = collage {
                pastedImages = loadPastedImages(from: collage)
                print("3")
            }
        }
        .onChange(of: scenePhase) { newPhase in
                    if newPhase == .active {
//                        loadData() // 앱이 포그라운드로 돌아왔을 때 데이터 로드
                        print("App has become active")
                    }
                }

    }


    func savePastedImages2(to collage: BCollage, pastedImages: [PastedImage], context: NSManagedObjectContext) {
        // 기존 관계 데이터를 가져옵니다
        guard let existingPhotos = collage.bPhotoForCollage as? Set<BPhotoForCollage> else {
            print("Error: Unable to cast bPhotoForCollage to Set<BPhotoForCollage>")
            return
        }

        // 기존 데이터 중 업데이트되지 않은 항목 삭제
        let pastedImageIDs = Set(pastedImages.map { $0.id })
        for existingPhoto in existingPhotos {
            if !pastedImageIDs.contains(existingPhoto.id ?? UUID()) {
                // 기존 데이터에서 더 이상 사용되지 않는 이미지를 삭제
                context.delete(existingPhoto)
            }
        }

        // 추가 및 업데이트 처리
        for pastedImage in pastedImages {
            if let existingPhoto = existingPhotos.first(where: { $0.id == pastedImage.id }) {
                // 기존 객체 업데이트
                existingPhoto.image = pastedImage.pastedImage.pngData()?.base64EncodedString()
                existingPhoto.posX = NSNumber(value: pastedImage.imagePosition.x)
                existingPhoto.posY = NSNumber(value: pastedImage.imagePosition.y)
                existingPhoto.rotation = NSNumber(value: pastedImage.angleSum)
                existingPhoto.scaleX = NSNumber(value: pastedImage.imageWidth)
                existingPhoto.scaleY = NSNumber(value: pastedImage.imageHeight)
            } else {
                // 새 객체 생성
                let newPhoto = BPhotoForCollage(context: context)
                newPhoto.id = pastedImage.id
                newPhoto.image = pastedImage.pastedImage.pngData()?.base64EncodedString()
                newPhoto.posX = NSNumber(value: pastedImage.imagePosition.x)
                newPhoto.posY = NSNumber(value: pastedImage.imagePosition.y)
                newPhoto.rotation = NSNumber(value: pastedImage.angleSum)
                newPhoto.scaleX = NSNumber(value: pastedImage.imageWidth)
                newPhoto.scaleY = NSNumber(value: pastedImage.imageHeight)

                // 새 사진을 collage에 추가
                collage.addToBPhotoForCollage(newPhoto)
            }
        }

        // Core Data 저장
        do {
            try context.save()
            print("Pasted images saved successfully!")
        } catch {
            print("Error saving pasted images: \(error)")
        }
    }


    func loadPastedImages(from collage: BCollage) -> [PastedImage] {
        guard let photos = collage.bPhotoForCollage as? Set<BPhotoForCollage> else {
            print("No photos found in collage")
            return []
        }

        return photos.compactMap { photo -> PastedImage? in
            guard
                let imageData = Data(base64Encoded: photo.image ?? ""),
                let uiImage = UIImage(data: imageData)
            else {
                print("Failed to decode photo: \(photo.id ?? UUID())")
                return nil
            }

            return PastedImage(
                imageWidth: photo.scaleX?.doubleValue ?? 1,
                imageHeight: photo.scaleY?.doubleValue ?? 1,
                imagePosition: CGPoint(x: photo.posX?.doubleValue ?? 0, y: photo.posY?.doubleValue ?? 0),
                angle: .zero,
                angleSum: photo.rotation?.doubleValue ?? 0,
                pastedImage: uiImage
            )
        }
    }

    func createAndAssignBCollage(for friend: BFriend, context: NSManagedObjectContext) -> BCollage {
        let newCollage = BCollage(context: context)
        newCollage.id = UUID()
        newCollage.backgroundColor = "FFFFFF"
        newCollage.status = "inprogress"

        // Friend의 collage 속성 업데이트
        friend.bCollage = newCollage

        do {
            try context.save()
            print("New collage assigned to friend and saved successfully.")
        } catch let error as NSError {
            print("Core Data Save Error: \(error), \(error.userInfo)")
        }

        return newCollage
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

//#Preview {
//    CollageByMyselfView()
//        .environmentObject(ColorManager())
//}

