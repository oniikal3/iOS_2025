//
//  TrackDO.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 28/2/25.
//

import Foundation

struct TrackDO: Identifiable, Hashable {
    let id: String
    let title: String
    let artist: String
    let previewURL: URL?
    let imageURL: URL?
    let duration: Int
    
    var endTime: String {
        let minutes = duration / 60
        let seconds = duration % 60
        return "\(minutes):\(seconds)"
    }
}
