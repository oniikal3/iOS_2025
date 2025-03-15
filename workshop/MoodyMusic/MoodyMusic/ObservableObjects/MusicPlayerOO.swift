//
//  MusicPlayerOO.swift
//  MoodyMusic
//
//  Created by Nathapong Masathien on 9/3/25.
//

import Foundation
import AVFoundation

@Observable
class MusicPlayerOO {
    var isPlayerPresented: Bool = false
    
    var tracks: [TrackDO] = []
    
    private var player: AVPlayer?
    private(set) var currentTrack: TrackDO? { // ให้ MusicOO เป็นคน set track ให้ currentTrack เท่านั้น
        didSet {
            if let currentTrack = currentTrack {
                createPlayer(for: currentTrack)
            }
        }
    }
    
    private func createPlayer(for track: TrackDO) {
        guard let previewURL = track.previewURL else { return }
        
        player = AVPlayer(url: previewURL) // สร้าง player ขึ้นมาใหม่
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    func stop() {
        player?.pause()
        player = nil
    }
    
    func play(_ tracks: [TrackDO], selectedTrack: TrackDO, showPlayer: Bool = true) async {
        self.tracks = tracks
        await play(selectedTrack, showPlayer: showPlayer)
    }
        
    private func play(_ track: TrackDO, showPlayer: Bool = true) async {
        if isPlayerPresented == false, showPlayer {
            isPlayerPresented = true
        }
        
        await fetchTrackDetails(for: track)
    }
    
    private func fetchTrackDetails(for track: TrackDO) async {
        do {
            let detail = try await SpotifyAPI.shared.getTrack(for: track.id)
            currentTrack = TrackDO(
                id: detail.id,
                title: detail.name,
                artist: detail.artists.first?.name ?? "Unknown",
                imageURL: detail.album.images.first?.url,
                duration: detail.duration_ms / 1000,
                previewURL: detail.preview_url
            )
            
        } catch {
            print("Failed to fetch track details: \(error)")
        }
    }
        
}
