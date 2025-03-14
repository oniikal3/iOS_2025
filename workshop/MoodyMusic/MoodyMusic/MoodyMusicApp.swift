//
//  MoodyMusicApp.swift
//  MoodyMusic
//
//  Created by Nathapong Masathien on 1/3/25.
//

import SwiftUI

@main
struct MoodyMusicApp: App {
    @State var player = MusicPlayerOO()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(player)
        }
    }
}

struct PreviewWrapper<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .environment(MusicPlayerOO())
    }
}
