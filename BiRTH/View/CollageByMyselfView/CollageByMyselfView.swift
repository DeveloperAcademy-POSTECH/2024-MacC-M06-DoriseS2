import SwiftUI
import CoreData

//최상위뷰
struct CollageByMyselfView: View {

    var bFriend: BFriend? = nil
//    var bCollage: BCollage? = nil

    @Environment(\.scenePhase) private var scenePhase

    @State var pastedImages: [PastedImage] = []
    @State var selectedImageID: UUID? = nil
    @State var isCustomSheet: Bool = false
    @State var sheetHeight: CGFloat = UIScreen.main.bounds.height * 0.2
    
    @Environment(\.managedObjectContext) private var viewContext

    @State private var collage: BCollage? = nil
    @Environment(\.dismiss) var dismiss

//    let collage: BCollage

    var body: some View {
        ZStack {
            // BackgroundColor
            Color.biRTH_mainColor.ignoresSafeArea()
            
            VStack {
//                ColByMyselfSaveView()
                HStack(spacing: 0) {
                    Spacer()

                    Image(systemName: "arrow.uturn.left")
                        .foregroundColor(.black)

                    Image(systemName: "arrow.uturn.right")
                        .foregroundColor(.black)

                    Button {
                        if let collage = collage {
                                savePastedImages2(to: collage, pastedImages: pastedImages, context: viewContext)
                            }
                        dismiss()
                    } label: {
                        Text("임시저장")
                            .foregroundColor(.black)
                            .padding(5)
                    }
                }.padding(0)

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

//    func loadData() {
//            // bFriend가 nil인지 확인
//            guard let unwrappedFriend = bFriend else {
//                print("Error: bFriend is nil")
//                return
//            }
//
//            // Collage가 없는 경우 생성
//            if unwrappedFriend.collage == nil {
//                let newCollage = createAndAssignBCollage(for: unwrappedFriend, context: viewContext)
//                collage = newCollage
//                print("1")
//            } else {
//                collage = unwrappedFriend.collage
//                print("2")
//            }
//
//            // PastedImages 로드
//            if let collage = collage {
//                pastedImages = loadPastedImages(from: collage)
//                print("3")
//            }
//        }

//    func createAndAssignBCollage(for friend: BFriend, context: NSManagedObjectContext) -> BCollage {
//        let newCollage = BCollage(context: context)
//        newCollage.id = UUID()
//        newCollage.photos = nil
//        newCollage.backgroundColor = "FFFFFF"
//        newCollage.status = "inprogress"
//
//        // Friend의 collage 속성 업데이트
//        friend.collage = newCollage
//
//        do {
//            try context.save()
//            print("New collage assigned to friend and saved successfully.")
//        } catch let error as NSError {
//            print("Core Data Save Error: \(error), \(error.userInfo)")
//        }
//
//        return newCollage
//    }
//
//
//    func savePastedImages(to collage: BCollage, pastedImages: [PastedImage], context: NSManagedObjectContext) {
//        // 기존 사진을 불러옵니다 (필요시 기존 사진 리스트)
//        let existingPhotos = collage.photos ?? []
//
//        // 추가 및 수정 처리
//        var updatedPhotos: [BPhotoForCollage] = []
//
//        for pastedImage in pastedImages {
//            // 기존 사진 중에 id가 일치하는 사진을 찾습니다
//            if let existingPhoto = existingPhotos.first(where: { $0.id == pastedImage.id }) {
//                // 수정된 경우 기존 데이터 업데이트
//                existingPhoto.image = pastedImage.pastedImage.pngData()?.base64EncodedString()
//                existingPhoto.posX = NSNumber(value: pastedImage.imagePosition.x)
//                existingPhoto.posY = NSNumber(value: pastedImage.imagePosition.y)
//                existingPhoto.rotation = NSNumber(value: pastedImage.angleSum)
//                existingPhoto.scaleX = NSNumber(value: pastedImage.imageWidth)
//                existingPhoto.scaleY = NSNumber(value: pastedImage.imageHeight)
//
//                // 업데이트된 사진을 배열에 추가
//                updatedPhotos.append(existingPhoto)
//            } else {
//                // 새로운 이미지를 추가
//                let newPhoto = BPhotoForCollage(context: context)
//                newPhoto.id = pastedImage.id
//                newPhoto.image = pastedImage.pastedImage.pngData()?.base64EncodedString()
//                newPhoto.posX = NSNumber(value: pastedImage.imagePosition.x)
//                newPhoto.posY = NSNumber(value: pastedImage.imagePosition.y)
//                newPhoto.rotation = NSNumber(value: pastedImage.angleSum)
//                newPhoto.scaleX = NSNumber(value: pastedImage.imageWidth)
//                newPhoto.scaleY = NSNumber(value: pastedImage.imageHeight)
//
//                // 새로운 사진을 배열에 추가
//                updatedPhotos.append(newPhoto)
//            }
//        }
//
//        // 수정 및 추가된 모든 사진을 collage에 연결
//        collage.photos = updatedPhotos
//
//        // Core Data 저장
//        do {
//            try context.save()
//            print("Pasted images saved successfully!")
//        } catch {
//            print("Error saving pasted images: \(error)")
//        }
//
//        // 저장 후, 불러와서 확인
//        let loadedImages = loadPastedImages(from: collage)
//        print("Loaded images after save: \(loadedImages)")
//    }
//
//
//    func savePastedImages2(to collage: BCollage, pastedImages: [PastedImage], context: NSManagedObjectContext) {
//        // 기존 사진을 불러옵니다 (필요시 기존 사진 리스트)
//        let existingPhotos = (collage.photos as? Set<BPhotoForCollage>) ?? []
//
//        // 추가 및 수정 처리
//        var updatedPhotos: [BPhotoForCollage] = []
//
//        for pastedImage in pastedImages {
//            // 기존 사진 중에 id가 일치하는 사진을 찾습니다
//            if let existingPhoto = existingPhotos.first(where: { $0.id == pastedImage.id }) {
//                // 수정된 경우 기존 데이터 업데이트
//                if let imageData = pastedImage.pastedImage.pngData() {
//                    existingPhoto.image = imageData.base64EncodedString()
//                } else {
//                    print("Error: Failed to encode image to Base64")
//                    continue
//                }
//                existingPhoto.posX = NSNumber(value: pastedImage.imagePosition.x)
//                existingPhoto.posY = NSNumber(value: pastedImage.imagePosition.y)
//                existingPhoto.rotation = NSNumber(value: pastedImage.angleSum)
//                existingPhoto.scaleX = NSNumber(value: pastedImage.imageWidth)
//                existingPhoto.scaleY = NSNumber(value: pastedImage.imageHeight)
//
//                // 업데이트된 사진을 배열에 추가
//                updatedPhotos.append(existingPhoto)
//            } else {
//                // 새로운 이미지를 추가
//                let newPhoto = BPhotoForCollage(context: context)
//                newPhoto.id = pastedImage.id
//                if let imageData = pastedImage.pastedImage.pngData() {
//                    newPhoto.image = imageData.base64EncodedString()
//                } else {
//                    print("Error: Failed to encode image to Base64")
//                    continue
//                }
//                newPhoto.posX = NSNumber(value: pastedImage.imagePosition.x)
//                newPhoto.posY = NSNumber(value: pastedImage.imagePosition.y)
//                newPhoto.rotation = NSNumber(value: pastedImage.angleSum)
//                newPhoto.scaleX = NSNumber(value: pastedImage.imageWidth)
//                newPhoto.scaleY = NSNumber(value: pastedImage.imageHeight)
//
//                // 새로운 사진을 배열에 추가
//                updatedPhotos.append(newPhoto)
//            }
//        }
//
//        // 수정 및 추가된 모든 사진을 collage에 연결
//        collage.photos = NSSet(array: updatedPhotos)
//
//        // Core Data 저장
//        do {
//            try context.save()
//            print("Pasted images saved successfully!")
//        } catch {
//            print("Error saving pasted images: \(error)")
//        }
//    }
//
//
//
////     BCollage의 photos 데이터를 PastedImage로 변환
//    func loadPastedImages(from collage: BCollage) -> [PastedImage] {
//        guard let photos = collage.photos else {
//            print("No photos found in collage")
//            return []
//        }
//
//        return photos.compactMap { (photo: BPhotoForCollage) -> PastedImage? in
//            guard
//                let imageData = Data(base64Encoded: photo.image ?? ""),
//                let uiImage = UIImage(data: imageData)
//            else {
//                print("Failed to decode photo: \(photo.id ?? UUID())")
//                return nil
//            }
//
//            print("Loaded photo ID: \(photo.id ?? UUID())")
//            return PastedImage(
//                imageWidth: photo.scaleX?.doubleValue ?? 1,
//                imageHeight: photo.scaleY?.doubleValue ?? 1,
//                imagePosition: CGPoint(x: photo.posX?.doubleValue ?? 0, y: photo.posY?.doubleValue ?? 0),
//                angle: .zero,
//                angleSum: photo.rotation?.doubleValue ?? 0,
//                pastedImage: uiImage
//            )
//        }
//    }

    func savePastedImages2(to collage: BCollage, pastedImages: [PastedImage], context: NSManagedObjectContext) {
        // 기존 관계 데이터를 불러옵니다
        let existingPhotos = collage.bPhotoForCollage ?? []

        if let existingPhotos = collage.bPhotoForCollage as? Set<BPhotoForCollage> {
            for pastedImage in pastedImages {
                if let existingPhoto = existingPhotos.first(where: { $0.id == pastedImage.id }) {
                    // 기존 객체 업데이트
                    if let imageData = pastedImage.pastedImage.pngData() {
                        existingPhoto.image = imageData.base64EncodedString()
                    } else {
                        print("Error: Failed to encode image to Base64")
                        continue
                    }
                    existingPhoto.posX = NSNumber(value: pastedImage.imagePosition.x)
                    existingPhoto.posY = NSNumber(value: pastedImage.imagePosition.y)
                    existingPhoto.rotation = NSNumber(value: pastedImage.angleSum)
                    existingPhoto.scaleX = NSNumber(value: pastedImage.imageWidth)
                    existingPhoto.scaleY = NSNumber(value: pastedImage.imageHeight)
                } else {
                    // 새 객체 생성 및 추가
                    let newPhoto = BPhotoForCollage(context: context)
                    newPhoto.id = pastedImage.id
                    if let imageData = pastedImage.pastedImage.pngData() {
                        newPhoto.image = imageData.base64EncodedString()
                    } else {
                        print("Error: Failed to encode image to Base64")
                        continue
                    }
                    newPhoto.posX = NSNumber(value: pastedImage.imagePosition.x)
                    newPhoto.posY = NSNumber(value: pastedImage.imagePosition.y)
                    newPhoto.rotation = NSNumber(value: pastedImage.angleSum)
                    newPhoto.scaleX = NSNumber(value: pastedImage.imageWidth)
                    newPhoto.scaleY = NSNumber(value: pastedImage.imageHeight)

                    // 새로운 사진을 collage에 추가
                    collage.addToBPhotoForCollage(newPhoto)
                }
            }
        } else {
            print("Error: Unable to cast bPhotoForCollage to Set<BPhotoForCollage>")
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


//
//#Preview {
//    CollageByMyselfView()
//        .environmentObject(ColorManager())
//}
