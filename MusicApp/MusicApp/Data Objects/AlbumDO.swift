//
//  AlbumDO.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 23/2/25.
//

import Foundation

protocol MediaItem: Identifiable, Hashable {
    var id: String { get }
    var title: String { get }
    var subtitle: String { get }
    var imageURL: URL? { get }
}

struct AlbumDO: MediaItem {
    let id: String
    let title: String
    let description: String?
    let artist: String // Might remove this later
    let cover: URL?
    
    var subtitle: String {
        artist
    }
    
    var imageURL: URL? {
        cover
    }
}
