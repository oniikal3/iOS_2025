//
//  PlaylistView.swift
//  MoodyMusic
//
//  Created by Nathapong Masathien on 1/3/25.
//

import SwiftUI

struct PlaylistView: View {
    
    @Environment(MusicPlayerOO.self) private var player: MusicPlayerOO
    
//    let playlist: PlaylistDO
    @State private var oo: PlaylistOO
    
    init(playlist: PlaylistDO) {
        _oo = State(initialValue: PlaylistOO(playlist: playlist))
    }
        
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    AsyncImage(url: oo.playlist.image) { image in
                        // โหลดรูปได้
                        image
                            .resizable()
    //                        .frame(width: 200, height: 200)
                    } placeholder: {
                        // ระหว่างรอโหลดรูป
                        Color.gray
    //                        .frame(width: 200, height: 200)
                    }
                    .frame(width: 200, height: 200)
                    .cornerRadius(16)
                    Spacer()
                }
                
                VStack(alignment: .leading) {
                    Text(oo.playlist.name)
                        .font(.title)
                        .bold()
                        
                    // Description
                    if let description = oo.playlist.description {
                        Text(description)
                            .font(.subheadline)
                    }
                }
                
                // Add, Download, Suffle and Play buttons
                HStack(spacing: 25) {
                    Button {
                        print("Add to library")
                    } label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    
                    Button {
                        print("Download")
                    } label: {
                        Image(systemName: "arrow.down.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    
                    Button {
                        print("ellipsis")
                    } label: {
                        Image(systemName: "ellipsis")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    
                    Spacer()

                    Button {
                        print("Shuffle")
                    } label: {
                        Image(systemName: "shuffle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }

                    Button {
                        print("Play")
                        withAnimation {
//                            player.isPlayerPresented = true
                            if let firstTrack = oo.tracks.first {
                                Task {
                                    await player.play(oo.tracks, selectedTrack: firstTrack)
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundStyle(.yellow)
                    }
                }
                
                // Track list
                LazyVStack {
//                    ForEach(1...10, id: \.self) { index in
//                        TrackRowView()
//                    }
                    ForEach(oo.tracks, id: \.id) { track in
                        TrackRowView(track: track)
                    }
                }
            }
            .padding(.horizontal)
        }
        .background(.gray)
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
}

#Preview {
    PreviewWrapper {
        PlaylistView(playlist: dummyPlaylist)
    }
}

// Dummy PlaylistDO data
let dummyPlaylist = PlaylistDO(id: "1",
                          name: "Playlist Name",
                          description: "Description",
                          image: URL(string: "https://picsum.photos/200"),
                          owner: "Owner name")

