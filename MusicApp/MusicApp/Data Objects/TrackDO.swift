//
//  TrackDO.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 28/2/25.
//

import Foundation

struct TrackDO: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var artist: String
    var previewURL: URL?
}
