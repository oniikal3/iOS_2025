//
//  FirstImmersiveApp.swift
//  FirstImmersive
//
//  Created by Nathapong Masathien on 13/3/25.
//

import SwiftUI

@main
struct FirstImmersiveApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.volumetric)
        
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
