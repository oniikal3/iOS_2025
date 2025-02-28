//
//  MainTabView.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 24/2/25.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var player: MusicPlayerOO
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .black
        
        // Set unselected tab item color
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
                        Label("Home", systemImage: "house.fill")
                    }
                
                Text("Search")
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                
                Text("Library")
                    .tabItem {
                        Label("Library", systemImage: "square.stack.fill")
                    }
            }
            .tint(.white)
            .background(.red)
//            .ignoresSafeArea(.keyboard, edges: .bottom)
            
            if player.isPlayerPresented {
                PlayerView()
                    .transition(.move(edge: .bottom))
//                    .ignoresSafeArea()
                    .zIndex(1) // Show above the tab view
            }
            
            // Mini Player at the bottom
            VStack {
                Spacer()
                
                if player.currentTrack != nil {
                    MiniPlayerView(isPresented: .constant(true))
                        .padding(.bottom, 49)
                        .onTapGesture {
                            withAnimation {
                                player.isPlayerPresented = true
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    PreviewWrapper {
        MainTabView()
    }
}
