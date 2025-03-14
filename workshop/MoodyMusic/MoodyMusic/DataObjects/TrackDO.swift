//
//  TrackDO.swift
//  MoodyMusic
//
//  Created by Nathapong Masathien on 15/3/25.
//

import Foundation

struct TrackDO {
    let id: String
    let title: String
    let artist: String
    let imageURL: URL?
    let duration: Int
    let previewURL: URL?
    
    var endTime: String {
        // Format duration to mm:ss
        let minutes = duration / 60
        let seconds = duration % 60
        return "\(minutes):\(seconds)"
    }
}
