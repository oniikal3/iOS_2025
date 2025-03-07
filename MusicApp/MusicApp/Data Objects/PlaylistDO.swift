//
//  PlaylistDO.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 6/3/25.
//

import Foundation

struct PlaylistDO: MediaItem {
    let id: String
    let name: String
    let description: String?
    let image: URL?
    let owner: String
    
    var title: String {
        name
    }
    
    var subtitle: String {
        owner
    }
    
    var imageURL: URL? {
        image
    }
}
