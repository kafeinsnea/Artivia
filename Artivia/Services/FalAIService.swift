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
        guard let requestURL = URL(string: "https://fal.run/fal-ai/image-editing/cartoonify") else {
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
        if let jsonString = String(data: data, encoding: .utf8) {
            print("FalAI response json: \(jsonString)")
        }
        
        let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
        
        guard let images = json["images"] as? [[String: Any]],
              let firstImage = images.first,
              let imageURLString = firstImage["url"] as? String,
              let imageURL = URL(string: imageURLString) else {
            throw NSError(domain: "FalAIError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Geçerli yanıt alınamadı"])
        }
      
        return imageURL
    }

    
    
    
}
