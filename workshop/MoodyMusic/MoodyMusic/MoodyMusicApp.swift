//
//  MoodyMusicApp.swift
//  MoodyMusic
//
//  Created by Nathapong Masathien on 1/3/25.
//

import SwiftUI
import SwiftData

@main
struct MoodyMusicApp: App {
    @State var player = MusicPlayerOO()
    @State var favoriteManager: FavoriteManager
    
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: FavTrack.self)
            favoriteManager = FavoriteManager(modelContext: container.mainContext)
        } catch {
            fatalError("Unable to create ModelContainer. Error: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(player)
                .environment(favoriteManager)
        }
        .modelContainer(container)
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
