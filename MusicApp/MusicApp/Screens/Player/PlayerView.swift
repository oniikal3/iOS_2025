//
//  PlayerView.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 15/2/25.
//

/* Todo
 - Make view scrollable
 - Add feature to show lyrics
 - Fix vinyl record rotation animation
 - Add feature to show lyrics
 - Button didn't change when track is ended
 */
import SwiftUI

struct PlayerView: View {
    @Environment(MusicPlayerOO.self) private var player
    @Environment(FavoriteManager.self) private var favoriteManager

    //    @Binding var isPresented: Bool
    
    @State private var rotation: Double = 0
    //    @State private var progress: Double = 0 // Move to OO model
    //    @State private var isPlaying = false // Move to OO model
    @State private var offsetY: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 30) {
                // Floating Custom Navigation Bar
                HStack {
                    Button(action: {
                        // Collapse player view
                        withAnimation {
                            player.isPlayerPresented = false
                        }
                    }) {
                        Image(systemName: "chevron.down")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    
                    Spacer()
                    
                    Text("Now Playing")
                        .font(.headline)
                    
                    Spacer()
                    
                    Button(action: {
                        // Ellipsis button
                    }) {
                        Image(systemName: "ellipsis")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                }
                .padding(.top, geometry.safeAreaInsets.top) // Adjust for safe area
                .background(Color.black.opacity(0.8))
                
                // Rotating vinyl record with animation effect when playing music with music image from URL
                AsyncImage(url: player.currentTrack?.imageURL) { image in
                    image
                        .resizable()
                } placeholder: {
                    Image(systemName: "music.note")
                        .resizable()
                        .scaledToFit()
                }
                .frame(width: 300, height: 300)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                .shadow(radius: 10)
                .rotationEffect(.degrees(rotation), anchor: .center)
//                .animation(.linear(duration: 10).repeatForever(autoreverses: false), value: rotation)
                .onChange(of: player.isPlaying, { oldValue, newValue in
                    print("Player is playing: \(newValue)")
                    if newValue {
                        withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                            rotation += 360
                        }
                    } else {
                        print("Player is not playing")
                        withAnimation {
                            rotation = rotation.truncatingRemainder(dividingBy: 360)
                        }
                    }
                })
//                .onAppear() {
//                    // Start rotating the vinyl record
//                    withAnimation {
//                        self.rotation = 360
//                    }
//                }
                
                // Music title and artist name
                VStack {
                    Text(player.currentTrack?.title ?? "Music Title")
                        .font(.title)
                    Text(player.currentTrack?.artist ?? "Artist Name")
                        .font(.title2)
                }
                
                // Linear progress bar for music playback
                VStack {
                    ProgressView(value: player.progress, total: 1)
                        .progressViewStyle(LinearProgressViewStyle())
                        .accentColor(.yellow)
                    HStack {
                        Text(player.progressTime)
                            .font(.caption)
                        Spacer()
                        Text(player.currentTrack?.endTime ?? "0:00")
                            .font(.caption)
                    }
                }
                .padding()
                
                HStack {
                    // Repeat button
                    Button(action: {
                        // Repeat music
                    }) {
                        Image(systemName: "repeat")
                            .font(.title2)
                    }
                    
                    Spacer()
                    
                    // Group of play, pause, and stop buttons and previous and next buttons
                    HStack {
                        Button(action: {
                            // Previous music
                        }) {
                            Image(systemName: "backward.fill")
                                .font(.title2)
                        }
                        
                        // Play/Pause toggle button
                        Button(action: {
                            if player.isPlaying {
                                // Stop rotating the vinyl record no need to set to 0
                                player.pause()
//                                withAnimation {
//                                    rotation = 0
//                                }
                                
                                // print check player isplaying
                                print("player is playing 1: \(player.isPlaying)")
                            } else {
                                // Start rotating the vinyl record
                                Task {
                                    await player.play()
                                    print("player is playing 2: \(player.isPlaying)")
//                                    rotation += 360
                                }
                            }
                        }) {
                            Image(systemName: player.isPlaying ? "pause.fill" : "play.fill")
                                .font(.title)
                        }
                        
                        Button(action: {
                            // Next music
                            Task {
                                await player.next()
                            }
                        }) {
                            Image(systemName: "forward.fill")
                                .font(.title2)
                        }
                    }
                    
                    Spacer()
                    
                    // Favorite button
                    Button(action: {
                        // Favorite music
                        if let trackId = player.currentTrack?.id {
                            favoriteManager.toggleFavorite(trackId: trackId)
                        }
                    }) {
                        let id = player.currentTrack?.id ?? ""
                        let isFavorite = favoriteManager.isFavorite(trackId: id)
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .font(.title2)
                            .foregroundStyle(isFavorite ? .red : .white)
                    }
                }
                .padding()
                
                Spacer()
                
            }
            .padding(.top, 20)
            //        .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline) // To remove white space at the top of view
            //            .toolbar {
            //                ToolbarItem(placement: .topBarLeading) {
            //                    Button(action: {
            //                        // Collapse player view
            //                        withAnimation {
            //                            isPresented.toggle()
            //                        }
            //                    }) {
            //                        Image(systemName: "chevron.down")
            //                    }
            //                }
            //                ToolbarItem(placement: .principal) {
            //                    Text("Now Playing")
            //                        .font(.headline)
            //                }
            //            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .ignoresSafeArea()
            .background(Color.black.ignoresSafeArea())
            .foregroundStyle(.white)
            .offset(y: offsetY)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.height > 0 {
                            offsetY = value.translation.height
                        }
                    }
                    .onEnded { value in
                        if value.translation.height > 200 {
                            // Collapse player view
                            withAnimation {
                                player.isPlayerPresented = false
                            }
                        }
                        withAnimation {
                            offsetY = 0
                        }
                    }
            )
        }
    }
}

#Preview {
    PreviewWrapper {
        PlayerView()
    }
    //    NavigationStack {
    //        PlayerView(isPresented: .constant(true))
    //    }
}
