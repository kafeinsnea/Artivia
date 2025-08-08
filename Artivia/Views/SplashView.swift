//
//  SplashView.swift
//  Artivia
//
//  Created by Sena Çırak on 8.08.2025.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0.0
    @State private var titleOffset: CGFloat = 30
    @State private var sparkleRotation: Double = 0
    
    var body: some View {
        if isActive {
            HomeView()
        } else {
            ZStack {
                // Gradient Background
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.purple.opacity(0.8),
                        Color.blue.opacity(0.6),
                        Color.indigo.opacity(0.9)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // Animated particles/sparkles in background
                ForEach(0..<15, id: \.self) { index in
                    Circle()
                        .fill(Color.white.opacity(0.1))
                        .frame(width: CGFloat.random(in: 4...12), height: CGFloat.random(in: 4...12))
                        .position(
                            x: CGFloat.random(in: 50...350),
                            y: CGFloat.random(in: 100...700)
                        )
                        .animation(.easeInOut(duration: Double.random(in: 2...4)).repeatForever(autoreverses: true), value: opacity)
                }
                
                VStack(spacing: 24) {
                    // Logo with sparkle icon
                    ZStack {
                        // Glow effect
                        Image(systemName: "sparkles")
                            .font(.system(size: 120, weight: .ultraLight))
                            .foregroundStyle(Color.white.opacity(0.3))
                            .blur(radius: 20)
                            .scaleEffect(1.5)
                        
                        // Main sparkle icon
                        Image(systemName: "sparkles")
                            .font(.system(size: 80, weight: .medium))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [Color.white, Color.yellow.opacity(0.8)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .rotationEffect(.degrees(sparkleRotation))
                    }
                    .scaleEffect(scale)
                    
                    // App Title
                    VStack(spacing: 8) {
                        Text("Artivia")
                            .font(.system(size: 42, weight: .bold, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [Color.white, Color.white.opacity(0.9)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .offset(y: titleOffset)
                            .opacity(opacity)
                        
                        Text("Transform your photos with AI")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(Color.white.opacity(0.8))
                            .offset(y: titleOffset)
                            .opacity(opacity * 0.8)
                    }
                    
                    // Loading indicator
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.2)
                        .opacity(opacity)
                }
            }
            .onAppear {
                // Sequential animations
                withAnimation(.easeOut(duration: 1.0)) {
                    scale = 1.0
                    opacity = 1.0
                }
                
                withAnimation(.easeOut(duration: 0.8).delay(0.3)) {
                    titleOffset = 0
                }
                
                withAnimation(.linear(duration: 3.0).repeatForever(autoreverses: false)) {
                    sparkleRotation = 360
                }
                
                // Transition to main app
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation(.easeInOut(duration: 0.6)) {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
