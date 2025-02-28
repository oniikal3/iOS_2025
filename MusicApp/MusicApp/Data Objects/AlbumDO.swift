//
//  AlbumDO.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 23/2/25.
//

import Foundation

struct AlbumDO: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String?
    let artist: String // Might remove this later
    let cover: String
}
