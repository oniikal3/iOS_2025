//
//  HorizontalSectionView.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 23/2/25.
//

import SwiftUI

struct HorizontalSectionView<T: MediaItem>: View {
    let section: String
    let items: [T]
    let onItemSelected: (T) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(section)
                .font(.title)
                .fontWeight(.bold)
                .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    // Loop through the albums with AlbumDO
                    ForEach(items) { item in
                        AlbumCardView(title: item.title, artist: item.subtitle, cover: item.imageURL,
                                      onTap: {
                            onItemSelected(item)
                        })
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 8)
        }
    }
}

#Preview {
    HorizontalSectionView(section: "Section Title",
                          items: [
                            AlbumDO(id: "1",
                                    title: "Album Title Album Title",
                                    description: "Lolem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                    artist: "Artist Name",
                                    cover: URL(string: "https://picsum.photos/200")
                                   ),
                            AlbumDO(id: "2",
                                    title: "Album Title",
                                    description: "Lolem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                    artist: "Artist Name",
                                    cover: URL(string: "https://picsum.photos/200")
                                   ),
                            AlbumDO(id: "3",
                                    title: "Album Title",
                                    description: "Lolem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                    artist: "Artist Name",
                                    cover: URL(string: "https://picsum.photos/200")
                                   )
                          ],
                          onItemSelected: { _ in }
    )
}
