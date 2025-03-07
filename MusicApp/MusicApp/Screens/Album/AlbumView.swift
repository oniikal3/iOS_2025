//
//  AlbumView.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 6/3/25.
//

import SwiftUI

struct AlbumView: View {
//    @EnvironmentObject var player: MusicPlayerOO
    @Environment(MusicPlayerOO.self) private var player

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
                        AsyncImage(url: album.cover) { image in
                            image
                                .resizable()
                        } placeholder: {
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
                                                
                        Button(action: {
                            print("Play button tapped")
//                            player.currentTrack = sampleTracks.first
                            
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
//                                player.currentTrack = selectedTrack
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
                AsyncImage(url: album.cover) { phase in
                    switch phase {
                    case .empty:
                        EmptyView()
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
                    @unknown default:
                        EmptyView()
                    }
                }
            )
        }

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

#Preview {
    PreviewWrapper {
        AlbumView(album: AlbumDO(id: "1",
                                 title: "Album Title",
                                 description: "A collection of The Carpenters' best songs.",
                                 artist: "Artist Name",
                                 cover: URL(string: "https://picsum.photos/200")
                                 )
)
    }
}
