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
    @State private var selectedPlaylist: PlaylistDO?
    
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
                    HorizontalSectionView(section: "Featured Playlists",
                                          items: oo.featuredPlaylists) { playlist in
                        self.selectedPlaylist = playlist
                    }
                    HorizontalSectionView(section: "New Releases", items: oo.newReleaseAlbums) { album in
                        self.selectedAlbum = album
                    }
                }
                .foregroundStyle(.white)
                .refreshable { // To make scroll view refreshable
                    await oo.fetch()
                }
                .overlay {
//                    if oo.isLoading {
//                        ProgressView("Refreshing...")
//                            .progressViewStyle(CircularProgressViewStyle())
//                            .scaleEffect(1.5, anchor: .center)
//                            .padding()
//                    }
                    oo.isLoading ? ProgressView("Refreshing...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1, anchor: .center)
                        .padding()
                    : nil
                }
            }
            .background(.black)
            .navigationDestination(item: $selectedAlbum, destination: { album in
                AlbumView(album: album)
            })
            .navigationDestination(item: $selectedPlaylist, destination: { playlist in
                PlaylistView(playlist: playlist)
            })
            .onAppear {
                if oo.featuredPlaylists.isEmpty && oo.newReleaseAlbums.isEmpty {
                    Task {
                        await oo.fetch()
                    }
                }
            }
        }
        .toolbarBackground(.black, for: .navigationBar)
        
    }
}

#Preview {
    HomeView(oo: MockHomeOO())
}
