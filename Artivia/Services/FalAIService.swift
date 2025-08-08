//
//  FalAIService.swift
//  Artivia
//
//  Created by Sena Çırak on 17.07.2025.
//

import Foundation

struct FalAIService{
    static let shared = FalAIService()
    
    
    func transformImage(with url: URL, style: String) async throws -> URL {
        let endpoint = getEndpointForStyle(style)
        guard let requestURL = URL(string: endpoint) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        request.setValue("Key \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "image_url": url.absoluteString
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, _) = try await URLSession.shared.data(for: request)
        
        let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
        print("🟣 FalAI response json: \(json)")

        // 1. image -> dict
        if let image = json["image"] as? [String: Any],
           let imageURLString = image["url"] as? String,
           let imageURL = URL(string: imageURLString) {
            print("✅ Found image in 'image': \(imageURL)")
            return imageURL
        }
        
        // 2. images -> array
        if let images = json["images"] as? [[String: Any]],
           let imageURLString = images.first?["url"] as? String,
           let imageURL = URL(string: imageURLString) {
            print("✅ Found image in 'images': \(imageURL)")
            return imageURL
        }

        // fallback
        throw NSError(domain: "FalAIError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Geçerli yanıt alınamadı"])
    }


    
    func getEndpointForStyle(_ style: String) -> String {
        switch style {
        case "Plushie":
            return "https://fal.run/fal-ai/plushify"
        case "Cartoon":
            return "https://fal.run/fal-ai/image-editing/cartoonify"
        case "Ghibli":
            return "https://fal.run/fal-ai/ghiblify"
        case "Professional":
            return "https://fal.run/fal-ai/image-editing/professional-photo"
        default:
            return "https://fal.run/fal-ai/image-editing/cartoonify"
        }
    }
}
