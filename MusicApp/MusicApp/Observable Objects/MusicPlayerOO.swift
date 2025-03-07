//
//  MusicPlayerOO.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 7/3/25.
//

import Foundation
import AVFoundation

@Observable
class MusicPlayerOO {
    private(set) var currentTrack: TrackDO?
    var isPlayerPresented = false
    var progress: Double = 0.0 // Playback progress (0.0 - 1.0)
    var progressTime: String {
        guard let player = player else { return "0:00" }
        let time = Int(player.currentTime().seconds)
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    // For student testing
    var durationTime: String {
        guard let player = player else { return "0:00" }
        let time = player.currentItem?.duration.seconds ?? 0
//        let time = Int(player.currentItem?.duration.seconds ?? 0)
        guard time.isFinite else { return "0:00" }
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
//    var isPlaying: Bool {
//        print("rate: \(player?.rate ?? 0)")
//        return player?.rate ?? 0 > 0
//    }
    private(set) var isPlaying: Bool = false
//    @Published var isPlaying: Bool = false
//    private(set) var isPlaying = false
    
    private var player: AVPlayer?
    private var playerObserver: Any?
    private var rateObserber: NSKeyValueObservation?
    
    init() {
        // Observe when the music is ended
        NotificationCenter.default.addObserver(forName: AVPlayerItem.didPlayToEndTimeNotification, object: nil, queue: .main) { [weak self] _ in
            self?.stop()
        }
        
    }
    
    func play(showPlayer: Bool = true) async {
        guard let currentTrack = currentTrack else { return }
        await play(currentTrack, showPlayer: showPlayer)
    }
    
    func play(_ track: TrackDO, showPlayer: Bool = true) async {
        if isPlayerPresented == false && showPlayer {
            isPlayerPresented = true
        }
        
        // if track is paused, resume
        if let player = player, let currentTrack = currentTrack, currentTrack.id == track.id {
            player.play()
//            isPlaying = true
            return
        } else {
            stop()
        }
        
        // if new track, fetch details and play
        await fetchTrackDetails(for: track)
        
        guard let previewURL = currentTrack?.previewURL else { return }
        
        player = AVPlayer(url: previewURL)
        player?.play()
        observePlayerStatus()
        observeProgress()
        observeRate()
//        isPlaying = true
    }
    
    func pause() {
        print("Pause")
        player?.pause()
        // Check rate
        print("rate in pause: \(player?.rate ?? 0)")
//        isPlaying = false
    }
    
    func stop() {
        player?.pause()
        player = nil
        progress = 0.0
//        isPlaying = false
    }
    
    private func fetchTrackDetails(for track: TrackDO) async {
        // check if the track is already fetched
        guard currentTrack?.id != track.id else { return }
        
        do {
            let detail = try await SpotifyAPI.shared.getTrack(for: track.id)
            print("Track detail: \(detail)")
            currentTrack = TrackDO(
                id: detail.id,
                title: detail.name,
                artist: detail.artists.first?.name ?? "Unknown",
                previewURL: detail.preview_url,
                imageURL: detail.album.images.first?.url,
                duration: detail.duration_ms / 1000
            )
            
        } catch {
            print("Failed to fetch track details: \(error)")
        }
    }
    
    private func observePlayerStatus() {
        guard let player = player else { return }
        
        playerObserver = player.addPeriodicTimeObserver(forInterval: CMTime(value: 1, timescale: 600), queue: .main, using: { [weak self] time in
            guard let self = self, let currentItem = player.currentItem else { return }
            
            if currentItem.status == .failed || time >= currentItem.duration {
                self.stop()
            }
        })
    }
    
    private func observeProgress() {
        guard let player = player else { return }
        
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.1, preferredTimescale: 600), queue: .main, using: { [weak self] time in
            guard let self = self, let duration = player.currentItem?.duration.seconds, duration > 0 else { return }
            // print time and duration
            print("Time: \(time.seconds), Duration: \(duration)")
            
            self.progress = time.seconds / duration
            print("Progress: \(self.progress)")
        })
    }
    
    private func observeRate() {
        rateObserber = player?.observe(\.rate, options: [.new, .initial], changeHandler: { [weak self] player, change in
            // print rate and change
            print("Rate: \(player.rate), Change: \(change)")
            self?.isPlaying = player.rate > 0
        })
    }
        
}
