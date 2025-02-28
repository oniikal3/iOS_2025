//
//  PlaylistView.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 15/2/25.
//

import SwiftUI

struct PlaylistView: View {
    @EnvironmentObject var player: MusicPlayerOO
    
    let album: AlbumDO
    
    private let actionButtonSize: CGFloat = 60
    private let buttonSize: CGFloat = 30
    
    @State private var isPlayerPresented = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Spacer()
                        
                        // Playlist cover image
                        AsyncImage(url: URL(string: album.cover)) { image in
                            image
                                .resizable()
                            //                        .scaledToFit()
//                                .frame(width: 200, height: 200)
//                                .cornerRadius(16)
                        } placeholder: {
//                            ProgressView()
                            Color.gray
                        }
                        .frame(width: 200, height: 200)
                        .cornerRadius(16)

                        Spacer()
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        // Playlist title
                        Text(album.title)
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .padding(.top, 16)
                        
                        // Description
                        if let description = album.description {
                            Text(description)
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                    }
                    
                    // Add, Download, Shuffle and Play buttons
                    HStack (spacing: 25) {
                        Button(action: {
                            print("Add button tapped")
                        }) {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .frame(width: buttonSize, height: buttonSize)
                        }
                        
                        Button(action: {
                            print("Download button tapped")
                        }) {
                            Image(systemName: "arrow.down.circle")
                                .resizable()
                                .frame(width: buttonSize, height: buttonSize)
                        }
                        
                        Button(action: {
                            print("More button tapped")
                        }) {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .scaledToFit()
                                .frame(width: buttonSize, height: buttonSize)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            print("Shuffle button tapped")
                        }) {
                            Image(systemName: "shuffle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: buttonSize, height: buttonSize)
                        }
                        
                        //                        NavigationLink(destination: PlayerView()) {
                        //                            Image(systemName: "play.circle")
                        //                                .resizable()
                        //                                .frame(width: actionButtonSize, height: actionButtonSize)
                        //                        }
                        
                        Button(action: {
                            print("Play button tapped")
                            player.currentTrack = sampleTracks.first
                            
                            withAnimation {
                                player.isPlayerPresented = true
                            }
                        }) {
                            Image(systemName: "play.circle")
                                .resizable()
                                .frame(width: actionButtonSize, height: actionButtonSize)
                        }
                    }
                    .foregroundStyle(.white)
                    
                    // List of songs
                    LazyVStack(alignment: .leading, spacing: 16) {
                        ForEach(sampleTracks, id: \.self) { track in
                            TrackRowView(track: track, onTap: { selectedTrack in
                                print("Track selected: \(selectedTrack.title)")
                                player.currentTrack = selectedTrack
                                withAnimation {
                                    player.isPlayerPresented = true
                                }
                            })
                        }
                    }
                }
            }
            .padding(.horizontal)
            .background(
                AsyncImage(url: URL(string: album.cover)) { phase in
                    switch phase {
                    case .empty:
                        EmptyView()
                        //                    ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .blur(radius: 10)
                            .overlay(gradientMask)
                            .ignoresSafeArea()
                    case .failure:
                        Color.black
                            .ignoresSafeArea()
//                        Image(systemName: "photo")
//                            .resizable()
//                            .scaledToFit()
                    @unknown default:
                        EmptyView()
                    }
                }
            )
//            .toolbarBackground(.black, for: .navigationBar)
//            .toolbarColorScheme(.dark, for: .navigationBar)
            
            /*
            // Mini player
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    
                    MiniPlayerView(isPresented: $isPlayerPresented)
                        .frame(width: geometry.size.width)
                        .ignoresSafeArea()
//                        .padding(.bottom, geometry.safeAreaInsets.bottom)
                        .padding(.bottom, 0)
                        .onTapGesture {
                            withAnimation {
                                isPlayerPresented = true
                            }
                        }
                }
            }
             */
//            MiniPlayerView(isPresented: $isPlayerPresented)
//                .onTapGesture {
//                    withAnimation {
//                        isPlayerPresented = true
//                    }
//                }
            
            // Show player view on top instead of mini player
//            if isPlayerPresented {
//                PlayerView(isPresented: $isPlayerPresented)
//                    .transition(.move(edge: .bottom))
//            }
        }
//        .fullScreenCover(isPresented: $isPlayerPresented) {
//            PlayerView(isPresented: $isPlayerPresented)
//        }

    }
    
    private var gradientMask: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                .clear,
                .black]),
            startPoint: .top,
            endPoint: .bottom
        )
        .blendMode(.destinationOut)
    }
}


// Sample data for playlist with 20 tracks with realistic song titles and artist names
let sampleTracks: [TrackDO] = [
    TrackDO(title: "Shape of You", artist: "Ed Sheeran"),
    TrackDO(title: "Blinding Lights", artist: "The Weeknd"),
    TrackDO(title: "Levitating", artist: "Dua Lipa"),
    TrackDO(title: "Peaches", artist: "Justin Bieber"),
    TrackDO(title: "Save Your Tears", artist: "The Weeknd"),
    TrackDO(title: "Good 4 U", artist: "Olivia Rodrigo"),
    TrackDO(title: "Kiss Me More", artist: "Doja Cat"),
    TrackDO(title: "Montero (Call Me By Your Name)", artist: "Lil Nas X"),
    TrackDO(title: "Stay", artist: "The Kid LAROI"),
    TrackDO(title: "Deja Vu", artist: "Olivia Rodrigo"),
    TrackDO(title: "Bad Habits", artist: "Ed Sheeran"),
    TrackDO(title: "Industry Baby", artist: "Lil Nas X"),
    TrackDO(title: "Butter", artist: "BTS"),
    TrackDO(title: "Happier Than Ever", artist: "Billie Eilish"),
    TrackDO(title: "Drivers License", artist: "Olivia Rodrigo"),
    TrackDO(title: "Leave The Door Open", artist: "Bruno Mars"),
    TrackDO(title: "Heat Waves", artist: "Glass Animals"),
    TrackDO(title: "Astronaut In The Ocean", artist: "Masked Wolf"),
    TrackDO(title: "Mood", artist: "24kGoldn"),
    TrackDO(title: "Dynamite", artist: "BTS")
]


#Preview {
    PreviewWrapper {
        PlaylistView(album:AlbumDO(title: "Album Title", description: "A collection of The Carpenters' best songs.", artist: "Artist Name", cover: "cover1"))
    }
}
