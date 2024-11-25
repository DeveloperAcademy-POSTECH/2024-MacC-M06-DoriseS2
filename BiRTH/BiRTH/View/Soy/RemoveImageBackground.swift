//
//  RemoveImageBackground.swift
//  BiRTH
//
//  Created by 이소현 on 11/23/24.
//

import SwiftUI
import Vision
import CoreImage.CIFilterBuiltins

struct RemoveImageBackground: View {
    @Binding var image: UIImage
    private var processingQueue = DispatchQueue(label: "ProcessingQueue")
    
    // 사용자 정의 초기화
    init(image: Binding<UIImage>) {
        self._image = image
    }
    
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
            
            Button("Remove Background") {
                createSticker()
                print("Remove Background")
            }
        }
        .padding()
    }
}

extension RemoveImageBackground {
    func createSticker() {
        guard let inputImage = CIImage(image: image) else {
            print("Failed to create CIImage")
            return
        }
        
        processingQueue.async {
            guard let maskImage = subjectMaskImage(from: inputImage) else {
                print("Failed to create mask image")
                return
            }
            
            let outputImage = apply(mask: maskImage, to: inputImage)
            let image = render(ciImage: outputImage)
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

#Preview {
//    RemoveImageBackground()
}
