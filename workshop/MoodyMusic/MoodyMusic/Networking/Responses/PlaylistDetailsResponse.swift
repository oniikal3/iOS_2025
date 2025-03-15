//
//  PlaylistDetailsResponse.swift
//  MoodyMusic
//
//  Created by Nathapong Masathien on 15/3/25.
//

import Foundation

struct PlaylistDetailsResponse: Decodable {
    let name: String
    let description: String
    let images: [SPTImage]
    let owner: Owner
    let tracks: Tracks
}

struct Tracks: Decodable {
    let items: [Track]
}

struct Track: Decodable {
    let track: TrackItem
}

struct TrackItem: Decodable {
    let id: String
    let name: String
    let artists: [Artist]
    let album: Album
    let duration_ms: Int
}

struct Artist: Decodable {
    let name: String
    let id : String
    let images: [SPTImage]?
}

struct Album: Decodable {
    let id: String
    let name: String
    let images: [SPTImage]
    let artists: [Artist]
}
