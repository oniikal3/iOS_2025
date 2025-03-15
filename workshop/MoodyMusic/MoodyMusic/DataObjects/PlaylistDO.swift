//
//  PlaylistDO.swift
//  MoodyMusic
//
//  Created by Nathapong Masathien on 15/3/25.
//

import Foundation

struct PlaylistDO: Hashable {
    let id: String
    let name: String
    let description: String?
    let image: URL?
    let owner: String
}
