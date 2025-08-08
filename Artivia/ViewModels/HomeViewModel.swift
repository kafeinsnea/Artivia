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
    
    var styles = ["Cartoon", "Plushie", "Ghibli", "Professional"]
    
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
    
    
    
    
    /*Bu fonksiyon, kullanıcı "Generate" butonuna bastığında çalışır ve:
     Fotoğrafı Firebase'e yükler
     Yapay zeka ile dönüştürür (seçilen stile göre)
     Sonucu indirir ve gösterir
     Otomatik olarak galeriye ekler (HomeView'daki onChange sayesinde)*/
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

    
    func getExampleForStyle(_ style: String) -> Image {
        switch style {
        case "Plushie":
            return Image("plushiestyle")
        case "Cartoon":
            return Image("cartoonstyle")
        case "Ghibli":
            return Image("ghiblistyle")
        case "Professional":
            return Image("professionalstyle")
        default:
            return Image("cartoonstyle")
        }
    }

}

