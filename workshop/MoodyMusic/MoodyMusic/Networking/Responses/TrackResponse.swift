//
//  TrackResponse.swift
//  MoodyMusic
//
//  Created by Nathapong Masathien on 15/3/25.
//

import Foundation

struct TrackResponse: Decodable {
    let id: String
    let name: String
    let preview_url: URL?
    let artists: [Artist]
    let album: Album
    let duration_ms: Int
}
