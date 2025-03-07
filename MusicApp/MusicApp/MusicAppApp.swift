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

/* Homework - Backlog
 - Use icon from image instead of systemName
 - Implement feature favorite music
 - Implement feature shuffle music
 - Implement search music
 */

@main
struct MusicAppApp: App {
    @State var player = MusicPlayerOO()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(player)
//            HomeView()
//                .environmentObject(player)
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
