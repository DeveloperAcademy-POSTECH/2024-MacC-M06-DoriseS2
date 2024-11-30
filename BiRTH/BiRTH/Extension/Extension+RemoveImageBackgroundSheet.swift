

import SwiftUI
import Vision
import CoreImage.CIFilterBuiltins

extension RemoveBackgroundButton {
    func createSticker() {
        guard let inputImage = CIImage(image: image) else {
            print("Failed to create CIImage")
            return
        }
        
        processingQueue.async {
            guard let maskImage = self.subjectMaskImage(from: inputImage) else {
                print("Failed to create mask image")
                return
            }
            
            let outputImage = self.apply(mask: maskImage, to: inputImage)
            let image = self.render(ciImage: outputImage)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
    
    func subjectMaskImage(from inputImage: CIImage) -> CIImage? {
        let handler = VNImageRequestHandler(ciImage: inputImage)
        let request = VNGenerateForegroundInstanceMaskRequest()
        
        do {
            try handler.perform([request])
            
            guard let result = request.results?.first else {
                print("No observations found")
                return nil
            }
            
            do {
                let maskPixelBuffler = try result.generateScaledMaskForImage(forInstances: result.allInstances, from: handler)
                return CIImage(cvImageBuffer: maskPixelBuffler)
            }
        } catch {
            print(error)
            return nil
        }
    }
    
    func apply(mask: CIImage, to image: CIImage) -> CIImage {
        let filter = CIFilter.blendWithMask()
        filter.inputImage = image
        filter.maskImage = mask
        filter.backgroundImage = CIImage.empty()
        
        return filter.outputImage!
    }
    
    func render(ciImage: CIImage) -> UIImage {
        guard let cgImage = CIContext(options: nil).createCGImage(ciImage, from: ciImage.extent) else {
            fatalError("Failed to render CGImage")
        }
        return UIImage(cgImage: cgImage)
    }
}
