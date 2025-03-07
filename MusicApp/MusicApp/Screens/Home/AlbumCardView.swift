//
//  AlbumCardView.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 23/2/25.
//

import SwiftUI

struct AlbumCardView: View {
    let title: String
    let artist: String
    let cover: URL?
    let onTap: () -> Void
    
    private let size = CGSize(width: 150, height: 150)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            AsyncImage(url: cover) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray
            }
                .frame(width: size.width, height: size.height)
//                .cornerRadius(12)
            
            Text(title)
                .lineLimit(1)
                .font(.headline)
                .bold()
                .frame(width: size.width, alignment: .leading)
            
            Text(artist)
                .lineLimit(1)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .frame(width: size.width, alignment: .leading)
        }
        .padding(.bottom, 4)
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    AlbumCardView(title: "Title", artist: "Michel Jackson", cover: URL(string: ""), onTap: {})
}
