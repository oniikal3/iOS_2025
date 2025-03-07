//
//  HomeOO.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 5/3/25.
//

import Foundation

@Observable
class HomeOO: ObservableObject {
    var featuredPlaylists: [PlaylistDO] = []
    var newReleaseAlbums: [AlbumDO] = []
    var artists: [ArtistDO] = []
    var isLoading = false
    
    @MainActor // Make sure to run this on the main thread
    func fetch() async {
        isLoading = true
        await fetchNewReleaseAlbums()
        await fetchFeaturedPlaylists()
        
        isLoading = false
    }
    
    private func fetchNewReleaseAlbums() async {
        do {
            let albums = try await SpotifyAPI.shared.getNewReleases()
            newReleaseAlbums = albums.albums.items.map { album in
                AlbumDO(
                    id: album.id,
                    title: album.name,
                    description: nil,
                    artist: album.artists.first?.name ?? "Unknown",
                    cover: album.images.first?.url
                )
            }
        } catch {
            print("New releases fetch failed: \(error)")
        }
    }
    
    private func fetchFeaturedPlaylists() async {
        do {
            let playlists = try await SpotifyAPI.shared.getFeaturedPlaylists()
            featuredPlaylists = playlists.playlists.items.map { playlist in
                PlaylistDO(
                    id: playlist.id,
                    name: playlist.name,
                    description: playlist.description,
                    image: playlist.images.first?.url,
                    owner: playlist.owner.display_name
                )
            }
        } catch {
            print("Featured playlists fetch failed: \(error)")
        }
    }

}
