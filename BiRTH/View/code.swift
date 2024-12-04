//import VisionKit // ImageAnalyzer를 사용하기 위해서 필요함
//
//
//let analyzer = ImageAnalyzer()
//let interaction = ImageAnalysisInteraction()
//
//@Published var detectedObjects: Set<ImageAnalysisInteraction.Subject> = []
////    let analyzer = ImageAnalyzer()
////    let interaction = ImageAnalysisInteraction()
//    private func generateImageForAllSelectedObjects() async throws { // 탐지된 피사체들을 하나의 이미지로 만들어줌
//        let allSubjectsImage = try await interaction.image(for: interaction.highlightedSubjects)
//        outputImage = allSubjectsImage
//    }
//    
//    private func analyzeImage(_ image: UIImage) async throws -> Set<ImageAnalysisInteraction.Subject> { // 몇개의 피사체가 있는 지 이미지를 분석
//        
//        let configuration = ImageAnalyzer.Configuration([.visualLookUp])
//        let analysis = try await analyzer.analyze(image, configuration: configuration)
//        interaction.analysis = analysis
//        let detectedSubjects = await interaction.subjects
//        return detectedSubjects
//    }
//    
//    func detectSubject(inputImage: UIImage?) {분석한 이미지에서 피사체만 감지
//        
//        Task { @MainActor in
//            
//            do {
//                guard let inputImage = inputImage else { return }
//                detectedObjects = try await self.analyzeImage(inputImage) // 분석하고 싶은 이미지를 넣고 탐지한 피사체들을 모두 넣어준다.
//                print("탐지된 피사체: \(detectedObjects.count)")
//                for i in detectedObjects {
//                    interaction.highlightedSubjects.insert(i)
//                    try await generateImageForAllSelectedObjects()
//                }
//                
//            } catch {
//                print("none object detected")
//            }
//            
//        }
//    }
