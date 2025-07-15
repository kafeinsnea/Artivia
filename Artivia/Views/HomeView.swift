//
//  HomeView.swift
//  Artivia
//
//  Created by Sena Çırak on 13.07.2025.
//

import SwiftUI
import PhotosUI

struct HomeView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @StateObject private  var photoVM = PhotoViewModel()
    @StateObject private  var homeVM = HomeViewModel()
    var body: some View {
        NavigationView{
            ZStack{
                //background
                LinearGradient(
                    gradient: Gradient(colors: [
                    Color.purple.opacity(0.1),
                    Color.blue.opacity(0.1),
                    Color.indigo.opacity(0.2)
                ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
               
                ScrollView{
                    VStack(spacing: 20){
                        //header
                        HeaderView
                        
                        //image input section
                        imageInputSection
                     
                        //sytle pick section
                       
                        
                        //generate button
                        generateButton
                        
                    }
                    .padding(.horizontal,20)
                    
                }
                
            }
            .fullScreenCover(isPresented: $homeVM.showResultSheet) {            ResultView(image: homeVM.generatedImage!){
                homeVM.generatedImage = nil
                     homeVM.showResultSheet = false
            }
            }
        }
        
    }

    
    var HeaderView: some View {
        VStack(spacing:12){
            HStack{
                Image(systemName: "sparkles")
                    .font(.title2)
                    .foregroundStyle(Color.white)
                    .frame(width: 44,height: 44)
                    .background(
                        LinearGradient(colors: [Color.purple,
                                                Color.blue], startPoint: .leading, endPoint: .trailing)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text("Artivia")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(LinearGradient(colors: [Color.purple, Color.blue], startPoint: .topLeading, endPoint: .bottomTrailing))
            }
            
            Text("Transform your photos with AI-powered artistic styles")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding(.top,20)
    }
    
    var imageInputSection: some View {
        VStack(spacing: 20) {
            if let image = homeVM.selectedImage {
                ZStack(alignment: .topTrailing){
                    Image(uiImage: image)
                        .resizable()
                        .frame(height:300)
                        .cornerRadius(16)
                    
                    PhotosPicker(selection: $selectedItem, matching: .images){
                        Image(systemName: "pencil.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.blue)
                            .padding(10)
                    }
                }
            } else{
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    VStack(spacing: 12) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 48))
                            .foregroundColor(.purple)
                        Text("Add Your Photo")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height:300)
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.purple.opacity(0.3),style: StrokeStyle(lineWidth: 2,dash: [8]))
                    )
                    .shadow(color:.black.opacity(0.05),radius: 8,x:0,y:2)
                }
            }
        }
        .padding()
        .onChange(of: selectedItem) { _, newItem in
            Task {
                do {
                    if let newItem,
                       let data = try await newItem.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        homeVM.selectedImage = uiImage
                    }
                } catch {
                    print("Resim alınamadı: \(error)")
                }
            }
        }
    }
    
    var stylePicker: some View {
        VStack {
          
        }
    }
    
    var generateButton: some View {
        Button{
            
        }label: {
            if homeVM.isGenerating{
                HStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(0.8)
                    Text("Generating")
                }
            } else{
                Image(systemName: "wand.and.rays")
                Text("Transform Image")
            }
        }
        .font(.headline)
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
        .disabled(homeVM.isGenerating || !homeVM.isReadyToGenerate)
        .opacity((homeVM.isGenerating || !homeVM.isReadyToGenerate) ? 0.5 : 1.0)

    }
}

#Preview {
    HomeView()
}
