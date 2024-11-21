import SwiftUI

struct GestureImageView: View {
    @ObservedObject var pastedImage: PastedImage // 개별 이미지 데이터
    @Binding var pastedImages: [PastedImage] // 전체 이미지 배열
    @GestureState private var startLocation: CGPoint? = nil // 드래그 시작 위치
    @Binding var selectedImageID: UUID?
    
    var body: some View {
        ZStack {
            // 이미지 뷰
            Image(uiImage: pastedImage.pastedImage)
                .resizable()
                .scaledToFit()
                .frame(width: pastedImage.imageWidth, height: pastedImage.imageHeight)
                .overlay {
                    if selectedImageID == pastedImage.id {
                        Rectangle()
                            .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [10]))
                    }
                }
                .zIndex(Double(findIndex(id: pastedImage.id)))
                .rotationEffect(pastedImage.angle)
                .position(pastedImage.imagePosition)
                .gesture(dragGesture)
                .gesture(resizeAndRotateGesture)
                .onTapGesture {
                    selectImage()
                    bringImageToFront()
                }
            
            if isSelected {
                // 회전 및 크기 조절 핸들
                Image(systemName: "arrow.up.backward.and.arrow.down.forward.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.gray)
                    .zIndex(Double(findIndex(id: pastedImage.id)) + 1)
                    .position(pastedImage.rotateDotPosition)
                    .gesture(resizeAndRotateGesture)
                
            }
        }
    }
    
    
    // MARK: - GestureImageView Computed Property
    // 선택 상태 확인
    private var isSelected: Bool {
        selectedImageID == pastedImage.id
    }
    
    // 이미지 선택
    private func selectImage() {
        if selectedImageID == pastedImage.id {
            selectedImageID = nil
        } else {
            selectedImageID = pastedImage.id
        }
    }
    
    // 이미지를 배열의 맨 뒤로 이동
    private func bringImageToFront() {
        if let index = pastedImages.firstIndex(where: { $0.id == pastedImage.id }) {
            let selectedImage = pastedImages.remove(at: index)
            pastedImages.append(selectedImage)
        }
    }
    
    // 드래그 제스처
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                let newLocation = startLocation ?? pastedImage.imagePosition
                pastedImage.imagePosition = CGPoint(
                    x: newLocation.x + value.translation.width,
                    y: newLocation.y + value.translation.height
                )
            }
            .updating($startLocation) { _, startLocation, _ in
                startLocation = startLocation ?? pastedImage.imagePosition
            }
    }
    
    // 크기 조절 및 회전 제스처
    private var resizeAndRotateGesture: some Gesture {
        DragGesture()
            .onChanged { gesture in
                let centerToNewPositionDistance = sqrt(pow(gesture.location.x - pastedImage.imagePosition.x, 2) + pow(gesture.location.y - pastedImage.imagePosition.y, 2))
                let imageDiagonal = sqrt(pow(pastedImage.imageWidth, 2) + pow(pastedImage.imageHeight, 2))
                
                pastedImage.imageWidth = centerToNewPositionDistance * 2 * pastedImage.imageWidth / imageDiagonal
                pastedImage.imageHeight = centerToNewPositionDistance * 2 * pastedImage.imageHeight / imageDiagonal
                
                let originalAngle = atan2(
                    pastedImage.rotateDotPosition.y - pastedImage.imagePosition.y,
                    pastedImage.rotateDotPosition.x - pastedImage.imagePosition.x
                )
                let newAngle = atan2(
                    gesture.location.y - pastedImage.imagePosition.y,
                    gesture.location.x - pastedImage.imagePosition.x
                )
                pastedImage.angleSum += (-(originalAngle - newAngle) * 180 / CGFloat.pi)
                pastedImage.angle = .degrees(pastedImage.angleSum)
            }
    }
    
    
    func findIndex(id: UUID) -> Int {
        for index in 0 ..< pastedImages.count {
            if pastedImages[index].id == id {
                return index
            }
        }
        
        return -1
        
    }
}
