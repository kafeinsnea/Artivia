//
//  ArtiviaApp.swift
//  Artivia
//
//  Created by Sena Çırak on 13.07.2025.
//

import SwiftUI
import Firebase

@main
struct ArtiviaApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}

