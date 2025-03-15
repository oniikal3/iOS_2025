//
//  PlaylistOO.swift
//  MoodyMusic
//
//  Created by Nathapong Masathien on 15/3/25.
//

import Foundation

@Observable
class PlaylistOO {
    var playlist: PlaylistDO
    var tracks: [TrackDO] = []
    
    init(playlist: PlaylistDO) {
        self.playlist = playlist
    }
    
    func fetchTracks() async {
        do {
            let details = try await SpotifyAPI.shared.getPlaylistDetails(for: playlist.id)
            tracks = details.tracks.items.map { item in
                TrackDO(
                    id: item.track.id,
                    title: item.track.name,
                    artist: item.track.artists.first?.name ?? "Unknown",
                    imageURL: item.track.album.images.first?.url,
                    duration: item.track.duration_ms / 1000,
                    previewURL: nil
                )
                
            }
        } catch {
            print("Failed to fetch playlist details: \(error)")
        }
    }
}
