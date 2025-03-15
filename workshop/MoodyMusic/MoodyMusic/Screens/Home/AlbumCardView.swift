//
//  AlbumCardView.swift
//  MoodyMusic
//
//  Created by Nathapong Masathien on 1/3/25.
//

import SwiftUI

struct AlbumCardView: View {
    
    var item: PlaylistDO
    var onTap: ((PlaylistDO) -> Void)? = nil
//    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
//            Image(systemName: "music.note")
            AsyncImage(url: item.image) { image in
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
            
            Text(item.owner)
                .font(.subheadline)
                .frame(width: 150, alignment: .leading)
                .lineLimit(1)
        }
        .padding(.bottom, 4)
        .onTapGesture {
            print("Tapped")
            onTap?(item) //callback
        }
    }
}

#Preview {
    AlbumCardView(item: PlaylistDO(id: "1",
                                   name: "Bohemian Rhapsody",
                                   description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nec eros auctor, fermentum purus ut, tincidunt felis.",
                                   image: URL(string: "https://picsum.photos/200"),
                                   owner: "Queen"
                                  )
                  )
}
