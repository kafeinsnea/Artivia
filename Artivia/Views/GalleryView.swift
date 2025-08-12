//
//  GalleryView.swift
//  Artivia
//
//  Created by Sena Çırak on 13.07.2025.
//

import SwiftUI

struct GalleryView: View {
    @EnvironmentObject var photoVM: PhotoViewModel
    @State private var selectedPhoto: PhotoModel? = nil

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(photoVM.gallery) { photo in
                    Button {
                        selectedPhoto = photo
                    } label: {
                        if let uiImage = photo.image {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .clipped()
                                .cornerRadius(10)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
        .navigationTitle("My Gallery")
        .fullScreenCover(item: $selectedPhoto) { photo in
            if let uiImage = photo.image {
                FullScreenPhotoView(
                    photo: photo,
                    image: uiImage,
                    onDelete: {
                        photoVM.deletePhoto(photo)
                        selectedPhoto = nil
                    },
                    onClose: {
                        selectedPhoto = nil
                    }
                )
                .environmentObject(photoVM)
            }
        }
    }
}

#Preview {
    GalleryView()
        .environmentObject(PhotoViewModel())
}
