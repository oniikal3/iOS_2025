//
//  HomeView.swift
//  MoodyMusic
//
//  Created by Nathapong Masathien on 1/3/25.
//

import SwiftUI

struct HomeView: View {    
    
    @State private var isPresented: Bool = false
    
    @State private var playlists: [Playlist] = []
    
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
                    AlbumHorizontalSectionView(items: playlists) {
                        print("Tapped album in HomeView")
                        isPresented = true
                    }
                    AlbumHorizontalSectionView {
                        isPresented = true
                    }
                }
                .foregroundStyle(.white)

            }
            .background(.black)
            .navigationDestination(isPresented: $isPresented) {
                PlaylistView()
            }
            .onAppear() {
                Task {
                    do {
                        let response = try await SpotifyAPI.shared.getChillPlaylists()
                        self.playlists = response.playlists.items
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
