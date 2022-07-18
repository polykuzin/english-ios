//
//  english.swift
//  english-ios
//
//  Created by polykuzin on 11/07/2022.
//

import SwiftUI

@main
struct english : App {
    
    @Environment(\.scenePhase)
    private var scenePhase : ScenePhase
    
    var body: some Scene {
        WindowGroup {
            TabbarView()
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .background :
                print("SUKAAAAA")
            default :
                print("SUKA")
            }
        }
    }
}
