
import SwiftUI
import Vision
import VisionKit
import CoreImage.CIFilterBuiltins

struct RemoveBackgroundButton: View {

    var processingQueue = DispatchQueue(label: "ProcessingQueue")
    
    @Binding var image: UIImage
    
    var body: some View {
        Button {
            createSticker()
            print("removeImageBackground")
        } label: {
            FeatureCircle(colorHex: "9694FF", featureImgName: "wand.and.rays", featureName: "배경제거")
        }
    }
}


@MainActor
class RemoveBackgroundViewModel: ObservableObject {
    @Published var detectedObjects: Set<ImageAnalysisInteraction.Subject> = []
    let analyzer = ImageAnalyzer()
    let interaction = ImageAnalysisInteraction()

    func detectSubject(inputImage: UIImage?) {
        Task { @MainActor in
            do {
                guard let inputImage = inputImage else { return }
                detectedObjects = try await self.analyzeImage(inputImage)
                print("탐지된 피사체: \(detectedObjects.count)")
            } catch {
                print("탐지된 피사체 없음")
            }
        }
    }

    private func analyzeImage(_ image: UIImage) async throws -> Set<ImageAnalysisInteraction.Subject> {
        let configuration = ImageAnalyzer.Configuration([.visualLookUp])
        let analysis = try await analyzer.analyze(image, configuration: configuration)
        interaction.analysis = analysis
        return await interaction.subjects
    }
}
