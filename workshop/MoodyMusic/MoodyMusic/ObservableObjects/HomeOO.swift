//
//  HomeOO.swift
//  MoodyMusic
//
//  Created by Nathapong Masathien on 15/3/25.
//

import Foundation

@Observable
class HomeOO {
    var chillPlaylist: [PlaylistDO] = []
//    var artist: [ArtistDO] = []
//    var newReleases: [AlbumDO] = []
    
    func fetch() async {
        await fetchChillPlaylist()
//        await fetchArtists()
//        await fetchNewReleases()
    }
    
    private func fetchChillPlaylist() async {
        do {
            let playlists = try await SpotifyAPI.shared.getChillPlaylists() // Request เพื่อ load ข้อมูลจาก SpotifyAPI
            chillPlaylist = playlists.playlists.items.map { playlist in // แปลงข้อมูลจาก response เป็น data object เพื่อใช้ใน view
                PlaylistDO(
                    id: playlist.id,
                    name: playlist.name,
                    description: playlist.description,
                    image: playlist.images.first?.url,
                    owner: playlist.owner.display_name
                )
            }
        } catch {
            print("Failed to fetch chill playlists: \(error)")
        }
    }

}
