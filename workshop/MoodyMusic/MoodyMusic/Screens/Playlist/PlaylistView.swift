//
//  PlaylistView.swift
//  MoodyMusic
//
//  Created by Nathapong Masathien on 1/3/25.
//

import SwiftUI

struct PlaylistView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    AsyncImage(url: URL(string: "https://picsum.photos/200")) { image in
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
                    Text("Bohemian Rhapsody")
                        .font(.title)
                        .bold()
                        
                    // Description
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nec eros auctor, fermentum purus ut, tincidunt felis.")
                        .font(.subheadline)
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
                    ForEach(1...10, id: \.self) { index in
                        TrackRowView()
                    }
                }
            }
            .padding(.horizontal)
        }
        .background(.gray)

    }
}

#Preview {
    PlaylistView()
}
