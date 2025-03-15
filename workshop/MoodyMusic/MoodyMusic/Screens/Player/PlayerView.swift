//
//  PlayerView.swift
//  MoodyMusic
//
//  Created by Nathapong Masathien on 1/3/25.
//

import SwiftUI

struct PlayerView: View {
    @Environment(MusicPlayerOO.self) private var player: MusicPlayerOO
    @Environment(FavoriteManager.self) private var favoriteManager: FavoriteManager
    
    @State private var rotation: Double = 0.0
    @State private var offsetY: CGFloat = 0.0
    
    var body: some View {
        VStack(spacing: 40) {
            HStack {
                Button {
                    print("Close player")
                    withAnimation {
                        player.isPlayerPresented = false
                    }
                } label: {
                    Image(systemName: "chevron.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                
                Spacer()
                
                Text("Now Playing")
                    .font(.headline)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }

            }
            
            AsyncImage(url: player.currentTrack?.imageURL) { image in
                image.resizable()
            } placeholder: {
                Image(systemName: "music.note")
                    .resizable()
                    .scaledToFit()
            }
            .frame(width: 300, height: 300)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(.gray, lineWidth: 4)
            }
            .shadow(radius: 10)
            .rotationEffect(.degrees(rotation), anchor: .center)
            .animation(.linear(duration: 5).repeatForever(autoreverses: false), value: rotation)
            .onAppear {
                rotation = 360
            }
            
//            Image(systemName: "music.note")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 300, height: 300)
//                .background(.gray)
//                .clipShape(Circle())
//                .overlay {
//                    Circle()
//                        .stroke(.black, lineWidth: 4)
//                }
//                .shadow(radius: 10)
//                .rotationEffect(.degrees(rotation), anchor: .center)
//                .animation(.linear(duration: 5).repeatForever(autoreverses: false), value: rotation)
//                .onAppear {
//                    rotation = 360
//                }
            
            
            // Music title and artist name
            VStack {
                Text(player.currentTrack?.title ?? "Unknown Title")
                    .font(.title)
                Text(player.currentTrack?.artist ?? "Unknown Artist")
                    .font(.title2)
            }
            
            // Linear progress bar
            VStack {
                ProgressView()
                    .progressViewStyle(LinearProgressViewStyle())
                HStack {
                    Text("0:00")
                        .font(.caption)
                    Spacer()
                    Text(player.currentTrack?.endTime ?? "00:00")
                        .font(.caption)
                }
            }
            
            // Player controls
            HStack {
                // Repeat button
                Button {
                    
                } label: {
                    Image(systemName: "repeat")
                        .font(.title2)
                }
                
                Spacer()
                
                HStack {
                    // Previous button
                    Button {
                        
                    } label: {
                        Image(systemName: "backward.fill")
                            .font(.title2)
                    }
                    
                    // Play and Stop Button
                    Button {
                        
                    } label: {
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(.yellow)
                    }
                    
                    // Next button
                    Button {
                        
                    } label: {
                        Image(systemName: "forward.fill")
                            .font(.title2)
                    }
                }
                
                Spacer()
                
                // Favorite button
                Button {
                    if let trackId = player.currentTrack?.id {
                        favoriteManager.toggleFavorite(trackId: trackId)
                    }
                } label: {
//                    Image(systemName: "heart.fill")
//                        .font(.title2)
                    let trackId = player.currentTrack?.id ?? ""
                    let isFavorite = favoriteManager.isFavorite(trackId: trackId)
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .font(.title2)
                        .foregroundStyle(isFavorite ? .red : .white)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(.black)
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
                    } else {
                        offsetY = 0
                    }
                }
        )
    }
}

#Preview {
    PreviewWrapper {
        PlayerView()
    }
}
