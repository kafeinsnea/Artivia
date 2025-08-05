//
//  PhotoViewModel.swift
//  Artivia
//
//  Created by Sena Çırak on 13.07.2025.
//

import SwiftUI

class PhotoViewModel: ObservableObject {
    @Published var gallery: [PhotoModel] = []
    
    private let galleryKey = "gallery_photos"
    
    init(){
        loadGallery()
    }
    
    func addPhoto(_ image: UIImage) {
        let photo = PhotoModel(image: image)
        gallery.insert(photo, at: 0)
        saveGallery()
    }
    
    private func saveGallery() {
        if let data = try? JSONEncoder().encode(gallery) {
            UserDefaults.standard.set(data, forKey: galleryKey)
        }
    }
    
    private func loadGallery() {
        if let data = UserDefaults.standard.data(forKey: galleryKey),
           let saved = try? JSONDecoder().decode([PhotoModel].self, from: data){
            self.gallery = saved
        }
    }
}
