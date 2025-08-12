//
//  FullScreenPhotoView.swift
//  Artivia
//
//  Created by Sena Çırak on 9.08.2025.
//

import SwiftUI

struct FullScreenPhotoView: View {
    let photo: PhotoModel
    let image: UIImage
    let onDelete: () -> Void
    let onClose: () -> Void
    
    @EnvironmentObject var photoVM: PhotoViewModel
    @State private var isShareSheetPresented: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { onClose() }
                        .foregroundStyle(Color.white)
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    Button {
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                    } label: {
                        Label("Save", systemImage: "square.and.arrow.down")
                    }
                    .foregroundStyle(Color.white)
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Button { isShareSheetPresented = true } label: {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                    .foregroundStyle(Color.white)
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Button(role: .destructive) {
                        onDelete()
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                    .foregroundStyle(Color.red)
                    .padding(.horizontal)
                }
            }
            .sheet(isPresented: $isShareSheetPresented) {
                ActivityView(activityItems: [image])
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .preferredColorScheme(.dark)
    }

}


