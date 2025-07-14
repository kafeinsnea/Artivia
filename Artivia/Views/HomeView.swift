//
//  HomeView.swift
//  Artivia
//
//  Created by Sena Çırak on 13.07.2025.
//

import SwiftUI

struct HomeView: View {
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
                
                VStack{
                    HeaderView
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
                                                Color.blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}

#Preview {
    HomeView()
}
