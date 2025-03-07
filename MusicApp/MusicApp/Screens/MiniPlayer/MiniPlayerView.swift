//
//  MiniPlayerView.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 22/2/25.
//

import SwiftUI

let miniPlayerHeight: CGFloat = 60

struct MiniPlayerView: View {
    //    @Binding var isPresented: Bool
    @Environment(MusicPlayerOO.self) private var player
    
    // Get current track from environment object
    
    var body: some View {
        VStack (spacing: 0) {
            HStack {
                // Cover image
                AsyncImage(url: player.currentTrack?.imageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    
                } placeholder: {
                    Color.gray
                        .frame(width: 40, height: 40)
                }
                
                // Track title and artist
                VStack(alignment: .leading, spacing: 0) {
                    Text(player.currentTrack?.title ?? "Unknown")
                        .font(.headline)
                        .bold()
                        .lineLimit(1)
                    
                    Text(player.currentTrack?.artist ?? "Unknown")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                
                Spacer()
                
                Button(action: {
                    if player.isPlaying {
                        player.pause()
                    } else {
                        Task {
                            await player.play(showPlayer: false)
                        }
                    }
                }) {
                    Image(systemName: player.isPlaying ? "pause.fill" : "play.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .tint(.yellow)
                        .padding(.trailing, 4)
                }
                
                
                //                Button(action: {
                //                    print("Next button tapped")
                //                }) {
                //                    Image(systemName: "forward.fill")
                //                        .resizable()
                //                        .frame(width: 20, height: 20)
                //                }
            }
            .frame(maxWidth: .infinity)
            .padding(8)
            .background(.ultraThinMaterial) // blur effect
            .cornerRadius(12)
            //            .shadow(radius: 10)
        }
        //        .padding(.bottom, safeAreaBottomInset())
        //        .padding(.bottom, 50)
        //        .padding(.bottom, 20)
    }
    
    private func safeAreaBottomInset() -> CGFloat {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else {
            return 0
        }
        
        return window.safeAreaInsets.bottom
    }
}

//#Preview {
//    let player = MusicPlayerOO()
//    MiniPlayerView(isPresented: .constant(true))
//        .environmentObject(player)
//}

struct MiniPlayerView_Previews: PreviewProvider {
    
    static var previews: some View {
        let player = MusicPlayerOO()
        let track = TrackDO(id: "1", title: "Preview Song", artist: "Artist name", previewURL: nil, imageURL: nil, duration: 100)
        //        Task {
        //            await player.play(track)
        //        }
        
        return MiniPlayerView()
            .environment(player)
    }
}
