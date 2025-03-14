//
//  PlaylistView.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 15/2/25.
//

import SwiftUI

struct PlaylistView: View {
    @Environment(MusicPlayerOO.self) private var player

    let playlist: PlaylistDO
    @StateObject private var oo: PlaylistOO
    
    private let actionButtonSize: CGFloat = 60
    private let buttonSize: CGFloat = 30
    
    @State private var isPlayerPresented = false
    
    init(playlist: PlaylistDO) {
        self.playlist = playlist
        _oo = StateObject(wrappedValue: PlaylistOO(playlist: playlist)) // Initialize PlaylistOO with the playlist
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Spacer()
                        
                        // Playlist cover image
                        AsyncImage(url: oo.playlist.image) { image in
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
                        Text(oo.playlist.name)
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .padding(.top, 16)
                        
                        // Description
                        if let description = oo.playlist.description {
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
                            if let firstTrack = oo.tracks.first {
                                Task {
//                                    await player.play(firstTrack)
                                    await player.play(oo.tracks, selectedTrack: firstTrack)
                                }
                            }
                            
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
                        ForEach(oo.tracks) { track in
                            TrackRowView(track: track, onTap: { selectedTrack in
                                print("Track selected: \(selectedTrack.title)")
                                Task {
                                    await player.play(oo.tracks, selectedTrack: selectedTrack)
                                }
                                withAnimation {
                                    player.isPlayerPresented = true
                                }
                            })
                        }
                    }
                }
                .padding(.bottom, player.currentTrack != nil ? miniPlayerHeight : 0)
            }
            .padding(.horizontal)
            .background(
                AsyncImage(url: playlist.image) { phase in
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
        .onAppear {
            if oo.tracks.isEmpty {
                Task {
                    await oo.fetchTracks()
                }
            }
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
    TrackDO(id: UUID().uuidString, title: "Shape of You", artist: "Ed Sheeran", previewURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"), imageURL: URL(string: "https://picsum.photos/200"), duration: 240),
    TrackDO(id: UUID().uuidString, title: "Blinding Lights", artist: "The Weeknd", previewURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3"), imageURL: URL(string: "https://picsum.photos/200"), duration: 200),
    TrackDO(id: UUID().uuidString, title: "Levitating", artist: "Dua Lipa", previewURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3"), imageURL: URL(string: "https://picsum.photos/200"), duration: 203),
    TrackDO(id: UUID().uuidString, title: "Peaches", artist: "Justin Bieber", previewURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3"), imageURL: URL(string: "https://picsum.photos/200"), duration: 198),
    TrackDO(id: UUID().uuidString, title: "Save Your Tears", artist: "The Weeknd", previewURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3"), imageURL: URL(string: "https://picsum.photos/200"), duration: 215),
    TrackDO(id: UUID().uuidString, title: "Good 4 U", artist: "Olivia Rodrigo", previewURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3"), imageURL: URL(string: "https://picsum.photos/200"), duration: 178),
    TrackDO(id: UUID().uuidString, title: "Kiss Me More", artist: "Doja Cat", previewURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3"), imageURL: URL(string: "https://picsum.photos/200"), duration: 208),
    TrackDO(id: UUID().uuidString, title: "Montero (Call Me By Your Name)", artist: "Lil Nas X", previewURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3"), imageURL: URL(string: "https://picsum.photos/200"), duration: 137),
    TrackDO(id: UUID().uuidString, title: "Stay", artist: "The Kid LAROI", previewURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-9.mp3"), imageURL: URL(string: "https://picsum.photos/200"), duration: 141),
    TrackDO(id: UUID().uuidString, title: "Deja Vu", artist: "Olivia Rodrigo", previewURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3"), imageURL: URL(string: "https://picsum.photos/200"), duration: 220),
    TrackDO(id: UUID().uuidString, title: "Bad Habits", artist: "Ed Sheeran", previewURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-11.mp3"), imageURL: URL(string: "https://picsum.photos/200"), duration: 231),
    TrackDO(id: UUID().uuidString, title: "Industry Baby", artist: "Lil Nas X", previewURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-12.mp3"), imageURL: URL(string: "https://picsum.photos/200"), duration: 212),
    TrackDO(id: UUID().uuidString, title: "Butter", artist: "BTS", previewURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3"), imageURL: URL(string: "https://picsum.photos/200"), duration: 164),
    TrackDO(id: UUID().uuidString, title: "Happier Than Ever", artist: "Billie Eilish", previewURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-14.mp3"), imageURL: URL(string: "https://picsum.photos/200"), duration: 298),
    TrackDO(id: UUID().uuidString, title: "Drivers License", artist: "Olivia Rodrigo", previewURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-15.mp3"), imageURL: URL(string: "https://picsum.photos/200"), duration: 242)
]

#Preview {
    PreviewWrapper {
        PlaylistView(
            playlist: PlaylistDO(
                id: "1",
                name: "Today's Hits",
                description: "The biggest hits from today's top artists",
                image: URL(string: "https://picsum.photos/200"),
                owner: "Apple Music"
            )
        )
    }
}
