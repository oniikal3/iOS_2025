//
//  PlaylistsResponse.swift
//  MoodyMusic
//
//  Created by Nathapong Masathien on 9/3/25.
//

import Foundation

struct PlaylistsResponse: Decodable {
    let playlists: Playlists
}

struct Playlists: Decodable {
    let items: [Playlist]
    let total: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        total = try container.decode(Int.self, forKey: .total)
        
        // Decode items array and filter out null values
        let itemsArr = try container.decode([Playlist?].self, forKey: .items)
        items = itemsArr.compactMap { $0 }
    }
    
    enum CodingKeys: String, CodingKey {
        case items
        case total
    }
}

struct Playlist: Decodable {
    let id: String
    let images: [SPTImage]
    let name: String
    let description: String?
    let owner: Owner
}

struct SPTImage: Decodable {
    let url: URL?
//    let height: Int?
//    let width: Int?
}

struct Owner: Decodable {
    let id: String
    let display_name: String
}
