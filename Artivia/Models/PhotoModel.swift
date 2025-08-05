//
//  PhotoModel.swift
//  Artivia
//
//  Created by Sena Çırak on 13.07.2025.
//

import Foundation
import UIKit

struct PhotoModel: Identifiable,Codable {
    let id: UUID
    let imageData: Data
    let date: Date
    
    init(image: UIImage,date: Date = Date()){
        self.id = UUID()
        self.imageData = image.jpegData(compressionQuality: 0.9) ?? Data()
        self.date = date
    }
    
    var image: UIImage? {
        UIImage(data: imageData)
    }
}
