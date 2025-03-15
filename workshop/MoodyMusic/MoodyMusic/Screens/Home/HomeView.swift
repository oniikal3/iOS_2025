//
//  HomeView.swift
//  MoodyMusic
//
//  Created by Nathapong Masathien on 1/3/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {    
    
    @State private var isPresented: Bool = false
    
//    @State private var playlists: [Playlist] = []
    @State private var oo = HomeOO()
    @State private var selectedPlaylist: PlaylistDO? // ใช้สำหรับเก็บค่า playlist ที่ user กด มาจาก card view
    
    @Query private var favoriteTracks: [FavTrack]
    
    var profileHeaderView: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .background(.gray)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("Hi, Nathapong")
                    .font(.subheadline)
                Text("Welcome back!")
                    .font(.headline)
                    .bold()
            }
            
            Spacer()
            
            Button {
                // do something
            } label: {
                Image(systemName: "bell")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.yellow)
            }
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading) {
                // Header Profile
                profileHeaderView
                    .foregroundStyle(.white)
                    .padding()
                
                // Album sections
                ScrollView(.vertical) {
                    AlbumHorizontalSectionView(items: oo.chillPlaylist) { selectedItem in
                        print("Tapped album in HomeView")
                        isPresented = true
                        selectedPlaylist = selectedItem
                    }
                    
                    AlbumHorizontalSectionView { _ in
                        isPresented = true
                    }
                    
                    // Favorite tracks
                    if !favoriteTracks.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 16) {
                                ForEach(favoriteTracks) { favTrack in
                                    VStack {
                                        Text(favTrack.trackId)
                                        Text(favTrack.dateAdded, style: .date)
                                    }
                                }
                            }
                        }
                    }
                }
                .foregroundStyle(.white)

            }
            .background(.black)
//            .navigationDestination(isPresented: $isPresented) {
//                PlaylistView(playlist: <#T##PlaylistDO#>)
//            }
            .navigationDestination(item: $selectedPlaylist, destination: { playlist in
                PlaylistView(playlist: playlist)
            })
            .onAppear() {
                if oo.chillPlaylist.isEmpty {
                    Task {
                        await oo.fetch()
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
