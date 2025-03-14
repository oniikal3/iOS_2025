//
//  MusicAppApp.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 15/2/25.
//

import SwiftUI


/* Homework #1
 - Implement Profile View
 */

/* Homework #2
 - Implement search bar in search view
 - Implement show artist in HomeView and make it clickable to ArtistView
 */

/* Homework #3
 - Implement back button in player view
 - Implement auto play next song
 */

/* Homework - Backlog
 - Use icon from image instead of systemName
 - Implement feature favorite music
 - Implement feature shuffle music
 - Implement search music
 */

import SwiftData

@main
struct MusicAppApp: App {
    
    let container: ModelContainer
    
    @State var player = MusicPlayerOO()
    @State var favoriteManager: FavoriteManager
    
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
            //            HomeView()
            //                .environmentObject(player)
        }
        .modelContainer(container)
    }
}


struct PreviewWrapper<Content: View>: View {
    let content: Content
    let container: ModelContainer
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
        do {
            container = try ModelContainer(for: FavTrack.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some View {
        content
            .environment(MusicPlayerOO())
            .environment(FavoriteManager(modelContext: container.mainContext))
            .modelContainer(container)
        
    }
}
