//
//  GalleryView.swift
//  Artivia
//
//  Created by Sena Çırak on 13.07.2025.
//

import SwiftUI

struct GalleryView: View {
    @EnvironmentObject var photoVM: PhotoViewModel

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(photoVM.gallery) { photo in
                    if let uiImage = photo.image {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipped()
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("My Gallery")
    }
}

#Preview {
    GalleryView()
        .environmentObject(PhotoViewModel())
}
