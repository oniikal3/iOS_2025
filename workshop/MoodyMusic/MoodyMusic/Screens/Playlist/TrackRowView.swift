//
//  TrackRowView.swift
//  MoodyMusic
//
//  Created by Nathapong Masathien on 1/3/25.
//

import SwiftUI

struct TrackRowView: View {
    let track: TrackDO
    
    var body: some View {
        HStack(spacing: 16) {
            // Track number
            Text("01")
                .font(.headline)
                .padding(.horizontal, 4)
            
            // Cover image
            AsyncImage(url: track.imageURL) { image in
                // โหลดรูปได้
                image
                    .resizable()
            } placeholder: {
                // ระหว่างรอโหลดรูป
                Color.gray
            }
            .frame(width: 60, height: 60)
            
            // Track title and artist name
            VStack(alignment: .leading) {
                Text(track.title)
                    .font(.headline)
                    .bold()
                Text(track.artist)
                    .font(.subheadline)
            }
            
            Spacer()
            
            // Options button
            Button {
                
            } label: {
                Image(systemName: "ellipsis")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }


        }
    }
}

#Preview {
    TrackRowView(track: dummyTrack)
}

let dummyTrack = TrackDO(id: "1",
                         title: "Title",
                         artist: "Artist",
                         imageURL: URL(string: "https://picsum.photos/200"),
                         duration: 0,
                         previewURL: nil)
