//
//  MainTabView.swift
//  MoodyMusic
//
//  Created by Nathapong Masathien on 9/3/25.
//

import SwiftUI

struct MainTabView: View {
    
    @Environment(MusicPlayerOO.self) private var player: MusicPlayerOO
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .black
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().tintColor = .white
        UITabBar.appearance().unselectedItemTintColor = .lightGray
    }
    
    var body: some View {
        ZStack {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                Text("Search")
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                
                Text("Library")
                    .tabItem {
                        Label("Library", systemImage: "square.stack")
                    }
            }
            .tint(.white)

            if player.isPlayerPresented {
                PlayerView()
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
//                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    PreviewWrapper {
        MainTabView()
    }
}
