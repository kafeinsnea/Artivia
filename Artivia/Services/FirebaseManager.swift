//
//  FirebaseManager.swift
//  Artivia
//
//  Created by Sena Çırak on 13.07.2025.
//

import Foundation
import FirebaseStorage
import UIKit

class FirebaseManager {
    static let shared = FirebaseManager()
    
    private let storage = Storage.storage()
    
    func uploadImage(_ image: UIImage) async throws -> URL {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw NSError(domain: "ImageError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Resim verisi oluşturulamadı"])
        }

        let filename = UUID().uuidString + ".jpg"
        let ref = storage.reference().child("uploads/\(filename)")
        
        let _ = try await ref.putDataAsync(imageData, metadata: nil)
        let downloadURL = try await ref.downloadURL()
        return downloadURL
    }
}
