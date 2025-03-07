//
//  PlaylistOO.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 6/3/25.
//

import Foundation

@Observable
class PlaylistOO: ObservableObject {
    var playlist: PlaylistDO
    private(set) var tracks: [TrackDO] = []
    
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
//                previewURL: item.track.preview_url,
                    previewURL: nil,
                    imageURL: item.track.album.images.first?.url,
                    duration: item.track.duration_ms / 1000
                )
            }
        } catch {
            print("Failed to fetch playlist details: \(error)")
        }
    }
}
