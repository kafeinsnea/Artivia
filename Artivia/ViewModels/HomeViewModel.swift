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
}

