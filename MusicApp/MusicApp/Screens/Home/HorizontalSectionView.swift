//
//  HorizontalSectionView.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 23/2/25.
//

import SwiftUI

struct HorizontalSectionView: View {
    let section: String
    let albums: [AlbumDO]
    let onAlbumTap: (AlbumDO) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(section)
                .font(.title)
                .fontWeight(.bold)
                .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    // Loop through the albums with AlbumDO
                    ForEach(albums) { album in
                        AlbumCardView(title: album.title, artist: album.artist, cover: album.cover,
                                      onTap: {
                                        onAlbumTap(album)
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
                          albums: [
                            AlbumDO(title: "Album Title Album Title",
                                    description: "Lolem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                    artist: "Artist Name",
                                    cover: "cover1"
                                   ),
                            AlbumDO(title: "Album Title",
                                    description: "Lolem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                    artist: "Artist Name",
                                    cover: "cover2"
                                   ),
                            AlbumDO(title: "Album Title",
                                    description: "Lolem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                    artist: "Artist Name",
                                    cover: "cover3"
                                   )
                          ],
                          onAlbumTap: { _ in }
    )
}
