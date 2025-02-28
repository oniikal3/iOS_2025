//
//  AlbumTracksResponse.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 28/2/25.
//

import Foundation

struct AlbumTracksResponse: Decodable {
    let items: [Track]
}

struct Track: Decodable, Hashable {
    let id: String
    let name: String
    let preview_url: URL?
    let artists: [Artist]
}
