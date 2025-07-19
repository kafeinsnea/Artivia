//
//  ResultView.swift
//  Artivia
//
//  Created by Sena Çırak on 13.07.2025.
//

import SwiftUI

struct ResultView: View {
    
    let image: UIImage
    let onDismiss: () -> Void
    @State private var isShareSheetPresented: Bool = false
    
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .cornerRadius(16)
                Spacer()
                HStack(spacing: 10) {
                    Button(action: saveImage) {
                        Label("Save", systemImage: "square.and.arrow.down")
                    }
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.purple]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    Button(action: { isShareSheetPresented = true }) {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.purple]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .font(.title2)
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        onDismiss()
                    }
                    .foregroundStyle(Color.purple)
                }
            }
            .sheet(isPresented: $isShareSheetPresented) {
                ActivityView(activityItems: [image])
            }
                      
        }
    }
    func saveImage() {
           UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
           // TODO: Aynı zamanda uygulama içi galeriye de kaydedilecek (ViewModel'de fonksiyon olabilir)
       }
}

// UIKit paylaşım sayfası için helper:
struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#Preview {
    ResultView(image: UIImage(named: "sampleImage") ?? UIImage()) {
    }
}

