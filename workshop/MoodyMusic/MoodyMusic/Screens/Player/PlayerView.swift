//
//  PlayerView.swift
//  MoodyMusic
//
//  Created by Nathapong Masathien on 1/3/25.
//

import SwiftUI

struct PlayerView: View {
    var body: some View {
        VStack(spacing: 40) {
            HStack {
                Button {
                    print("Close player")
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
            
            Image(systemName: "music.note")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .background(.gray)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(.black, lineWidth: 4)
                }
                .shadow(radius: 10)
            
            // Music title and artist name
            VStack {
                Text("Bohemian Rhapsody")
                    .font(.title)
                Text("Queen")
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
                    Text("3:00")
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
                    
                } label: {
                    Image(systemName: "heart.fill")
                        .font(.title2)
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    PlayerView()
}
