//
//  HomeViewModel.swift
//  Artivia
//
//  Created by Sena Çırak on 15.07.2025.
//

import SwiftUI

@MainActor
class HomeViewModel: ObservableObject{
    @Published var selectedImage: UIImage? = nil
    @Published var selectedStyleIndex: Int? = nil
    @Published var isGenerating: Bool = false
    @Published var generatedImage: UIImage? = nil
    @Published var showResultSheet: Bool = false
    
    var styles = ["Cartoon", "Oil Painting", "Sketch", "Watercolor", "Pixel Art"]
    
    var isReadyToGenerate: Bool {
        selectedImage != nil && selectedStyleIndex != nil
    }
    
    func uploadSelectedImageToFirebase() async throws -> URL {
        guard let image = selectedImage else {
            throw NSError(domain: "NoImage", code: 1, userInfo: [NSLocalizedDescriptionKey: "Seçilen resim yok."])
        }
        
        let url = try await FirebaseManager.shared.uploadImage(image)
        return url
    }
    
    func generateImage() async {
        isGenerating = true
         defer { isGenerating = false }

        do {
            let firebaseURL = try await uploadSelectedImageToFirebase()
            let resultURL = try await FalAIService.shared.transformImage(with: firebaseURL, style: styles[selectedStyleIndex ?? 0])
            
            // Sonucu indir
            let (data, _) = try await URLSession.shared.data(from: resultURL)
            if let image = UIImage(data: data) {
                generatedImage = image
                showResultSheet = true
            }
        } catch {
            print("Dönüştürme hatası: \(error)")
        }

        isGenerating = false
    }


}

