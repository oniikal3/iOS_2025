//
//  AlbumCardView.swift
//  MoodyMusic
//
//  Created by Nathapong Masathien on 1/3/25.
//

import SwiftUI

struct AlbumCardView: View {
    
    var item: Playlist
    var onTap: (() -> Void)? = nil
//    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
//            Image(systemName: "music.note")
            AsyncImage(url: item.images[0].url) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .background(.gray)
            } placeholder: {
                Color.gray
                    .frame(width: 150, height: 150)
            }
            
            Text(item.name)
                .font(.headline)
                .bold()
                .frame(width: 150, alignment: .leading)
                .lineLimit(1)
            
            Text(item.owner.display_name)
                .font(.subheadline)
                .frame(width: 150, alignment: .leading)
                .lineLimit(1)
        }
        .padding(.bottom, 4)
        .onTapGesture {
            print("Tapped")
            onTap?() //callback
        }
    }
}

#Preview {
    AlbumCardView(item: Playlist(id: "1",
                                 images: [SPTImage(url: URL(string: "https://picsum.photos/200"))],
                                 name: "Album Name",
                                 owner: Owner(id: "1", display_name: "Owner")))
}
