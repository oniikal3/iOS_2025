//
//  TrackRowView.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 26/2/25.
//

import SwiftUI

struct TrackRowView: View {
    let track: TrackDO
    var onTap: (TrackDO) -> Void = {_ in }
    
    var body: some View {
        HStack(spacing: 16) {
//            Image(systemName: "music.note")
//                .resizable()
//                .frame(width: 60, height: 60)
//                .cornerRadius(8)
            AsyncImage(url: URL(string: "")) { image in
                image
                    .resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 60, height: 60)

            
            VStack(alignment: .leading, spacing: 0) {
                Text(track.title)
                    .font(.headline)
                    .bold()
                Text(track.artist)
                    .font(.subheadline)
            }
            .foregroundColor(.white)
            
            Spacer()
            
            Button(action: {
                print("More button tapped")
            }) {
                Image(systemName: "ellipsis")
                    .foregroundStyle(.white)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onTap(track)
        }
//        .background(Color.white.opacity(0.5))
//        .cornerRadius(8)
    }
}

#Preview {
    TrackRowView(track: TrackDO(title: "Title", artist: "Artist"))
        .background(Color.black)
}
