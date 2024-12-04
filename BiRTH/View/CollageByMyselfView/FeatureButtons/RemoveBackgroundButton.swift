
import SwiftUI
import Vision
import VisionKit
import CoreImage.CIFilterBuiltins

struct RemoveBackgroundButton: View {
    
    var processingQueue = DispatchQueue(label: "ProcessingQueue")
    @StateObject var viewModel: RemoveBackgroundViewModel = RemoveBackgroundViewModel()
    
    @Binding var image: UIImage
    @Binding var pastedImages: [PastedImage]
    @Binding var selectedImageID: UUID?
    
    let maxWidth: CGFloat = 200
    
    var body: some View {
        Button {
            removeBackground()
            print("removeImageBackground")
        } label: {
            FeatureCircle(colorHex: "9694FF", featureImgName: "wand.and.rays", featureName: "배경제거")
        }
    }
    
    
    //    func createSticker() {
    //        guard let inputImage = CIImage(image: image) else {
    //            print("Failed to create CIImage")
    //            return
    //        }
    //
    //        processingQueue.async {
    //            guard let maskImage = subjectMaskImage(from: inputImage) else {
    //                print("Failed to create mask image")
    //                return
    //            }
    //
    //            let outputImage = apply(mask: maskImage, to: inputImage)
    //            let renderedImage = render(ciImage: outputImage)
    //
    //            DispatchQueue.main.async {
    //                self.image = renderedImage // 바인딩된 이미지 업데이트
    //                self.updateImageFrame(for: renderedImage) // 크기 업데이트
    //            }
    //        }
    //    }
    //
    //    func subjectMaskImage(from inputImage: CIImage) -> CIImage? {
    //        let handler = VNImageRequestHandler(ciImage: inputImage)
    //        let request = VNGenerateForegroundInstanceMaskRequest()
    //
    //        do {
    //            try handler.perform([request])
    //
    //            guard let result = request.results?.first else {
    //                print("No observations found")
    //                return nil
    //            }
    //
    //            let maskPixelBuffer = try result.generateScaledMaskForImage(forInstances: result.allInstances, from: handler)
    //
    //            print("\(inputImage)")
    //
    //            return CIImage(cvImageBuffer: maskPixelBuffer)
    //        } catch {
    //            print(error)
    //            return nil
    //        }
    //    }
    //
    //    func apply(mask: CIImage, to image: CIImage) -> CIImage {
    //        let filter = CIFilter.blendWithMask()
    //        filter.inputImage = image
    //        filter.maskImage = mask
    //        filter.backgroundImage = CIImage.empty()
    //
    //        return filter.outputImage ?? CIImage.empty()
    //    }
    //
    //    func render(ciImage: CIImage) -> UIImage {
    //        guard let cgImage = CIContext(options: nil).createCGImage(ciImage, from: ciImage.extent) else {
    //            fatalError("Failed to render CGImage")
    //        }
    //        return UIImage(cgImage: cgImage)
    //    }
    //
    //    func updateImageFrame(for image: UIImage) {
    //        guard let cgImage = image.cgImage else { return }
    //        let width = CGFloat(cgImage.width)
    //        let height = CGFloat(cgImage.height)
    //
    //        print("New Image Dimensions: \(width)x\(height)")
    //        // 필요한 경우 ViewModel에 크기 정보를 업데이트하거나 View에서 활용 가능
    //    }
    
    private func removeBackground() {
        guard let selectedImageID = selectedImageID,
              let selectedIndex = pastedImages.firstIndex(where: { $0.id == selectedImageID }),
              let inputImage = CIImage(image: pastedImages[selectedIndex].pastedImage) else {
            print("No image selected or failed to create CIImage")
            return
        }
        
        processingQueue.async {
            guard let maskImage = createMask(from: inputImage) else { return }
            let resultImage = apply(mask: maskImage, to: inputImage)
            let finalImage = render(ciImage: resultImage)
            
            DispatchQueue.main.async {
                // 크기 조정
                let originalSize = finalImage.size
                let aspectRatio = originalSize.height / originalSize.width
                let resizedWidth = min(maxWidth, originalSize.width)
                let resizedHeight = resizedWidth * aspectRatio
                
                
                pastedImages[selectedIndex].pastedImage = finalImage
                pastedImages[selectedIndex].imageWidth = resizedWidth
                pastedImages[selectedIndex].imageHeight = resizedHeight
            }
        }
    }
    
    private func createMask(from image: CIImage) -> CIImage? {
        let handler = VNImageRequestHandler(ciImage: image)
        let request = VNGenerateForegroundInstanceMaskRequest()
        do {
            try handler.perform([request])
            guard let result = request.results?.first else { return nil }
            let pixelBuffer = try result.generateScaledMaskForImage(forInstances: result.allInstances, from: handler)
            return CIImage(cvImageBuffer: pixelBuffer)
        } catch {
            print("Error generating mask: \(error)")
            return nil
        }
    }
    
    private func apply(mask: CIImage, to image: CIImage) -> CIImage {
        let filter = CIFilter.blendWithMask()
        filter.inputImage = image
        filter.maskImage = mask
        filter.backgroundImage = CIImage.empty()
        return filter.outputImage ?? CIImage.empty()
    }
    
    private func render(ciImage: CIImage) -> UIImage {
        guard let cgImage = CIContext().createCGImage(ciImage, from: ciImage.extent) else {
            fatalError("Failed to render CGImage")
        }
        return UIImage(cgImage: cgImage)
    }
}



@MainActor
class RemoveBackgroundViewModel: ObservableObject {
    @Published var processedImage: UIImage?
    @Published var imageFrame: CGSize = .zero // 이미지 크기 정보 추가
    
    func processImage(_ inputImage: UIImage, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let ciInputImage = CIImage(image: inputImage) else {
                print("Failed to convert UIImage to CIImage")
                completion(nil)
                return
            }
            
            guard let maskImage = self.generateMask(from: ciInputImage) else {
                print("Failed to generate mask")
                completion(nil)
                return
            }
            
            let outputImage = self.applyMask(maskImage, to: ciInputImage)
            let finalImage = self.renderImage(from: outputImage)
            
            DispatchQueue.main.async {
                self.updateImageFrame(from: finalImage) // 크기 정보 업데이트
                completion(finalImage)
            }
        }
    }
    
    private func generateMask(from inputImage: CIImage) -> CIImage? {
        let handler = VNImageRequestHandler(ciImage: inputImage)
        let request = VNGenerateForegroundInstanceMaskRequest()
        
        do {
            try handler.perform([request])
            
            guard let result = request.results?.first else {
                print("No foreground detected")
                return nil
            }
            
            let pixelBuffer = try result.generateScaledMaskForImage(forInstances: result.allInstances, from: handler)
            return CIImage(cvImageBuffer: pixelBuffer)
        } catch {
            print("Mask generation error: \(error)")
            return nil
        }
    }
    
    private func applyMask(_ mask: CIImage, to inputImage: CIImage) -> CIImage {
        let filter = CIFilter.blendWithMask()
        filter.inputImage = inputImage
        filter.maskImage = mask
        filter.backgroundImage = CIImage.empty()
        return filter.outputImage ?? inputImage
    }
    
    private func renderImage(from ciImage: CIImage) -> UIImage {
        guard let cgImage = CIContext().createCGImage(ciImage, from: ciImage.extent) else {
            fatalError("Failed to render CGImage")
        }
        return UIImage(cgImage: cgImage)
    }
    
    private func updateImageFrame(from image: UIImage) {
        guard let cgImage = image.cgImage else { return }
        let width = CGFloat(cgImage.width)
        let height = CGFloat(cgImage.height)
        
        self.imageFrame = CGSize(width: width, height: height) // 크기 업데이트
    }
}
