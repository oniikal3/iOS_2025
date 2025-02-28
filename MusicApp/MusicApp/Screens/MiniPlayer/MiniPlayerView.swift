//
//  MiniPlayerView.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 22/2/25.
//

import SwiftUI

struct MiniPlayerView: View {
    @Binding var isPresented: Bool
    @EnvironmentObject var player: MusicPlayerOO
    
    // Get current track from environment object
    
    var body: some View {
        if let track = player.currentTrack {
            VStack {
                HStack {
                    // Cover image
                    AsyncImage(url: URL(string: "")) { image in
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
                        Text(track.title)
                            .font(.headline)
                            .bold()
                            .lineLimit(1)
                        
                        Text(track.artist)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        print("Play button tapped")
                    }) {
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
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
                .padding()
                .background(.red)
                .background(.ultraThinMaterial) // blur effect
                .cornerRadius(12)
                //            .shadow(radius: 10)
            }
            //        .padding(.bottom, safeAreaBottomInset())
            //        .padding(.bottom, 50)
            //        .padding(.bottom, 20)
        }
    }
    
    private func safeAreaBottomInset() -> CGFloat {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else {
            return 0
        }
        
        return window.safeAreaInsets.bottom
    }
}

//#Preview {
//    MiniPlayerView(isPresented: .constant(true))
//        .environmentObject(MusicPlayerOO())
//}

struct MiniPlayerView_Previews: PreviewProvider {
    
    static var previews: some View {
        let player = MusicPlayerOO()
        player.currentTrack = TrackDO(title: "Preview Song", artist: "Artist name")

        return MiniPlayerView(isPresented: .constant(true))
            .environmentObject(player)
    }
}
