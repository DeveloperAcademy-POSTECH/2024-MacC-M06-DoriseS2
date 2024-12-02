import SwiftUI
import CoreData

//최상위뷰
struct CollageByMyselfView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var colorManager: ColorManager
    
    
    var bFriend: BFriend? = nil
    //    var bCollage: BCollage? = nil
    
    @State var pastedImages: [PastedImage] = []
    @State var selectedImageID: UUID? = nil
    @State var isCustomSheet: Bool = false
    @State var sheetHeight: CGFloat = 0.2
    @State private var collage: BCollage? = nil
    @State var dragOffset: CGSize = .zero

   
    //    let collage: BCollage
    
    
    var body: some View {
        ZStack {
            // BackgroundColor
            Color.biRTH_mainColor.ignoresSafeArea()
            
            
            VStack {
                
                
                ColByMyselfTopView(bFriend: bFriend!)
                
                imageField
                            
                ColByMyselfBottomView(selectedPhotos: $pastedImages)
                
            }
            .sheet(isPresented: $isCustomSheet) {
                if let selectedIndex = pastedImages.firstIndex(where: { $0.id == selectedImageID }) {
                    CustomSheet(
                        selectedImage: $pastedImages[selectedIndex].pastedImage,
                        pastedImages: $pastedImages,
                        selectedImageID: $selectedImageID
                    )
                    .presentationBackground(.black)
                    .interactiveDismissDisabled()
                    .presentationDetents([.fraction(sheetHeight)])
                    .presentationCornerRadius(16)
                    .presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.2)))
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
                
                Button {
                    if let collage = collage {
                        savePastedImages2(to: collage, pastedImages: pastedImages, context: viewContext)
                    }
                    dismiss()
                } label: {
                    Text("임시저장")
                        .foregroundColor(.black)
                }
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
    
    
    /// 삭제된 이미지를 Core Data에서도 삭제하는 함수
    func deleteImageFromCollage(id: UUID) {
        guard let collage = collage,
              let existingPhotos = collage.bPhotoForCollage as? Set<BPhotoForCollage> else {
            print("Error: Unable to access BPhotoForCollage")
            return
        }
        
        if let photoToDelete = existingPhotos.first(where: { $0.id == id }) {
            viewContext.delete(photoToDelete)
            do {
                try viewContext.save()
                print("Image deleted successfully from Core Data")
            } catch {
                print("Error deleting image from Core Data: \(error)")
            }
        }
    }
    
    func savePastedImages2(to collage: BCollage, pastedImages: [PastedImage], context: NSManagedObjectContext) {
        guard let existingPhotos = collage.bPhotoForCollage as? Set<BPhotoForCollage> else {
            print("Error: Unable to cast bPhotoForCollage to Set<BPhotoForCollage>")
            return
        }
        
        let pastedImageIDs = Set(pastedImages.map { $0.id })
        for existingPhoto in existingPhotos {
            if !pastedImageIDs.contains(existingPhoto.id ?? UUID()) {
                context.delete(existingPhoto)
            }
        }
        
        for pastedImage in pastedImages {
            if let existingPhoto = existingPhotos.first(where: { $0.id == pastedImage.id }) {
                existingPhoto.image = pastedImage.pastedImage.pngData()?.base64EncodedString()
                existingPhoto.posX = NSNumber(value: pastedImage.imagePosition.x)
                existingPhoto.posY = NSNumber(value: pastedImage.imagePosition.y)
                existingPhoto.rotation = NSNumber(value: pastedImage.angleSum)
                existingPhoto.scaleX = NSNumber(value: pastedImage.imageWidth)
                existingPhoto.scaleY = NSNumber(value: pastedImage.imageHeight)
            } else {
                let newPhoto = BPhotoForCollage(context: context)
                newPhoto.id = pastedImage.id
                newPhoto.image = pastedImage.pastedImage.pngData()?.base64EncodedString()
                newPhoto.posX = NSNumber(value: pastedImage.imagePosition.x)
                newPhoto.posY = NSNumber(value: pastedImage.imagePosition.y)
                newPhoto.rotation = NSNumber(value: pastedImage.angleSum)
                newPhoto.scaleX = NSNumber(value: pastedImage.imageWidth)
                newPhoto.scaleY = NSNumber(value: pastedImage.imageHeight)
                collage.addToBPhotoForCollage(newPhoto)
            }
        }
        
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

