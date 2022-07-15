//
//  EnglishApp.swift
//  english
//
//  Created by polykuzin on 11/07/2022.
//

import SwiftUI

@main
struct EnglishApp : App {
    
    @Environment(\.scenePhase)
    private var phase : ScenePhase
    
    var body: some Scene {
        WindowGroup {
            TabbarView()
        }
        .onChange(of: phase) { phase in
            switch phase {
            case .active:
                // App became active
                break
            case .inactive:
                // App became inactive
                break
            case .background:
                // App is running in the background
                break
            @unknown default:
                // Fallback for future cases
                break
            }
        }
    }
}

struct ContentView : View {
    
    var body : some View {
        Text("Hello, English!")
            .padding()
    }
}

struct ContentView_Previews : PreviewProvider {
    
    static var previews : some View {
        ContentView()
    }
}
