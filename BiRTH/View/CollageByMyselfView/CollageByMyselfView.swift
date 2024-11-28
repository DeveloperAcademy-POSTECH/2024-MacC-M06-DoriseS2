import SwiftUI
import CoreData

//최상위뷰
struct CollageByMyselfView: View {

    var bFriend: BFriend? = nil
//    var bCollage: BCollage? = nil

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
                                savePastedImages(to: collage, pastedImages: pastedImages, context: viewContext)
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
            // bFriend 확인
            print("1")
            guard let unwrappedFriend = bFriend else {
                print("Error: bFriend is nil")
                return
            }
            print("2")
            // Collage 생성 및 할당
            if unwrappedFriend.collage == nil {
                print("3")
                let newCollage = createAndAssignBCollage(for: unwrappedFriend, context: viewContext)
                print("4")
                collage = newCollage
            }

            // PastedImages 로드
            if let collage = unwrappedFriend.collage {
                print("5")
                pastedImages = loadPastedImages(from: collage)
            }
        }
    }
    func createAndAssignBCollage(for friend: BFriend, context: NSManagedObjectContext) -> BCollage {
        let newCollage = BCollage(context: context)
        newCollage.id = UUID()
        newCollage.photos = nil
        newCollage.backgroundColor = "FFFFFF"
        newCollage.status = .none
        print("6")
        bFriend!.collage = newCollage
        print("7")

        do {
            try context.save()
        } catch {
            print("Failed to save collage: \(error)")
        }
        print("8")
        return newCollage
    }

    func savePastedImages(to collage: BCollage, pastedImages: [PastedImage], context: NSManagedObjectContext) {
        // 기존 photos 가져오기
        let existingPhotos = collage.photos ?? []

        // 추가 및 수정 처리
        for pastedImage in pastedImages {
            if let existingPhoto = existingPhotos.first(where: { $0.id == pastedImage.id }) {
                // 수정된 경우 기존 데이터 업데이트
                existingPhoto.image = pastedImage.pastedImage.pngData()?.base64EncodedString()
                existingPhoto.posX = NSNumber(value: pastedImage.imagePosition.x)
                existingPhoto.posY = NSNumber(value: pastedImage.imagePosition.y)
                existingPhoto.rotation = NSNumber(value: pastedImage.angleSum)
                existingPhoto.scaleX = NSNumber(value: pastedImage.imageWidth)
                existingPhoto.scaleY = NSNumber(value: pastedImage.imageHeight)
            } else {
                // 새로운 이미지를 추가
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

        // 삭제된 이미지를 photos에서 제거
        let pastedImageIDs = pastedImages.map { $0.id }
        for existingPhoto in existingPhotos where !pastedImageIDs.contains(existingPhoto.id ?? UUID()) {
            collage.removeFromBPhotoForCollage(existingPhoto)
            context.delete(existingPhoto)
        }

        // 변경 사항 저장
        do {
            try context.save()
            print("Pasted images saved successfully!")
        } catch {
            print("Error saving pasted images: \(error)")
        }
    }



    // BCollage의 photos 데이터를 PastedImage로 변환
    func loadPastedImages(from collage: BCollage) -> [PastedImage] {
        let photos = collage.photos ?? [] // Optional이 아니므로 바로 할당 가능

        return photos.compactMap { (photo: BPhotoForCollage) -> PastedImage? in
            guard
                let imageData = Data(base64Encoded: photo.image ?? ""),
                let uiImage = UIImage(data: imageData)
            else {
                return nil
            }

            return PastedImage(
                imageWidth: photo.scaleX?.doubleValue ?? 1,
                imageHeight: photo.scaleY?.doubleValue ?? 1,
                imagePosition: CGPoint(x: photo.posX?.doubleValue ?? 0, y: photo.posY?.doubleValue ?? 0),
                angle: .zero, // 이 부분은 필요에 따라 수정
                angleSum: photo.rotation?.doubleValue ?? 0,
                pastedImage: uiImage
            )
        }
    }

}


//
//#Preview {
//    CollageByMyselfView()
//        .environmentObject(ColorManager())
//}
