import SwiftUI
import CoreData
import Photos


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
    @State var isAbleClosed: Bool = false
    @State private var capturedImage: UIImage?
    @State var showingAlert = false
    
    var undoManager = UndoManager()
    
    //    let collage: BCollage
    
    
    var body: some View {
        ZStack {
            // BackgroundColor
            Color.biRTH_mainColor.ignoresSafeArea()
            
            
            VStack {
                
                
                ColByMyselfTopView(bFriend: bFriend!)
                
                imageField
                
                //                // 캡처된 이미지 표시
                //                if let capturedImage = capturedImage {
                //                    Image(uiImage: capturedImage)
                //                        .resizable()
                //                        .scaledToFit()
                //                        .frame(height: 200)
                //                        .border(Color.green, width: 2)
                //                }
                
               
                ColByMyselfBottomView(selectedPhotos: $pastedImages)
                
            }
            .sheet(isPresented: $isCustomSheet) {
                if let selectedIndex = pastedImages.firstIndex(where: { $0.id == selectedImageID }) {
                    CustomSheet(
                        selectedImage: $pastedImages[selectedIndex].pastedImage,
                        pastedImages: $pastedImages,
                        selectedImageID: $selectedImageID, isCustomSheet: $isCustomSheet
                    )
                    .presentationBackground(.black)
                    .presentationCornerRadius(16)
                    .interactiveDismissDisabled()
                    .presentationDetents([.height(180)])
                    .presentationBackgroundInteraction(.enabled(upThrough: .height(180)))
                }
            }
            
        }
        
        
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    if let collage = collage {
                        savePastedImages2(to: collage, pastedImages: pastedImages, context: viewContext)
                    }
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                }
                
            }
            
            
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 4) {
                    Button {
                        print("undo")
                        viewContext.undo()
                    } label: {
                        Image(systemName: "arrow.uturn.left")
                            .foregroundStyle(.black)
                    }
                    
                    Button {
                        print("redo")
                        viewContext.redo()
                    } label: {
                        Image(systemName: "arrow.uturn.forward")
                            .foregroundStyle(.black)
                    }
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                
                Button {
                    showingAlert = true
                    print("paperplane")
                } label: {
                    Image(systemName: "paperplane")
                        .foregroundStyle(.black)
                }
                .alert(isPresented: $showingAlert) {
                    let firstButton = Alert.Button.cancel(Text("캡쳐하기")) {
                        // imageField 캡처
                        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) // imageField의 크기와 동일
                        capturedImage = imageField.snapshot(of: frame)
                        
                        if let capturedImage = capturedImage {
                            saveImageToPhotosAlbum(capturedImage)
                        } else {
                            print("no save")
                        }
                        print("secondary button pressed")
                    }
                    
                    let secondButton = Alert.Button.default(Text("공유하기")) {
                        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) // imageField의 크기와 동일
                        capturedImage = imageField.snapshot(of: frame)
                        if let capturedImage = capturedImage {
                            shareImage(capturedImage)
                        } else {
                            print("not share")
                        }
                    }
                    
                    return Alert(title: Text("저장하기"),
                                 message: Text("이미지를 저장합니다."),
                                 primaryButton: firstButton, secondaryButton: secondButton)
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
    
    @MainActor func snapshot() -> Image? {
        let imagerenderer = ImageRenderer(
            content: imageField.frame(maxWidth: 100, maxHeight: 100)
        )
        
        // 옵셔널 처리: uiImage가 nil인 경우 nil 반환
        guard let uiImage = imagerenderer.uiImage else {
            print("Failed to render image.")
            return nil
        }
        
        return Image(uiImage: uiImage)
    }
    
    
    /// 이미지 저장
    func saveImageToPhotosAlbum(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        // 사진 권한 요청 및 상태에 따른 처리
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    print("Image saved successfully!")
                case .denied, .restricted, .notDetermined:
                    print("Permission denied or not determined.")
                case .limited:
                    print("Image saved with limited access!")
                @unknown default:
                    break
                }
            }
        }
    }

    /// 이미지 공유
    func shareImage(_ image: UIImage) {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows
            .first else {
            print("Failed to fetch the key window.")
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        guard let rootVC = window.rootViewController else { return }
        rootVC.present(activityViewController, animated: true)
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

extension View {
    // 특정 영역만 캡처하기 위한 Snapshot 함수
    func snapshot(of rect: CGRect? = nil) -> UIImage? {
        let hostingController = UIHostingController(rootView: self)
        let targetView = hostingController.view
        
        // Ensure the view is laid out
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = hostingController
        window.makeKeyAndVisible()
        hostingController.view.layoutIfNeeded()
        
        let renderer = UIGraphicsImageRenderer(bounds: rect ?? targetView!.bounds)
        return renderer.image { context in
            targetView?.layer.render(in: context.cgContext)
        }
    }
}

//#Preview {
//    CollageByMyselfView()
//        .environmentObject(ColorManager())
//}




