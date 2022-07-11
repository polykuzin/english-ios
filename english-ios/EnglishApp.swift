//
//  EnglishApp.swift
//  english
//
//  Created by polykuzin on 11/07/2022.
//

import SwiftUI

@main
struct EnglishApp : App {
    var body: some Scene {
        WindowGroup {
            ContentView()
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
