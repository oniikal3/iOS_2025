//
//  HomeView.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 22/2/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var oo = HomeOO()
    @State private var selectedAlbum: AlbumDO?
    
    // Header view
    var profileHeaderView: some View {
        HStack {
            // Profile picture mask in circle shape
            Image(systemName: "person.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .background(.gray)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Welcome back!")
                    .font(.title2)
                    .bold()
                
                Text("Nathapong Masathien")
                    .font(.subheadline)
            }
            
            Spacer()
            
            Button(action: {
                // Notification button tapped
            }) {
                Image(systemName: "bell")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.yellow)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                // Welcome back header with notification button
                profileHeaderView
                    .foregroundColor(.white)
                    .padding()
                
                // Album sections
                ScrollView(.vertical, showsIndicators: false) {
                    HorizontalSectionView(section: "Recently",
                                          albums: oo.recentlyAlbums) { album in
                        self.selectedAlbum = album
                    }
                    HorizontalSectionView(section: "Popular", albums: oo.popularAlbums) { album in
                        self.selectedAlbum = album
                    }
                }
                .foregroundStyle(.white)
            }
            .background(.black)
            .navigationDestination(item: $selectedAlbum, destination: { album in
                PlaylistView(album: album)
            })
            .onAppear {
                oo.fetch()
            }
        }
        .toolbarBackground(.black, for: .navigationBar)
        
    }
}

#Preview {
    HomeView(oo: MockHomeOO())
}
