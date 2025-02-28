//
//  MusicAppApp.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 15/2/25.
//

import SwiftUI

@main
struct MusicAppApp: App {
    @StateObject var player = MusicPlayerOO()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(player)
        }
    }
}


// Will move this to a new file later
@Observable
class MusicPlayerOO: ObservableObject {
    var currentTrack: TrackDO?
    var isPlayerPresented = false
}


struct PreviewWrapper<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .environmentObject(MusicPlayerOO())
    }
}
