//
//  HomeOO.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 23/2/25.
//

import Foundation
import MusicKit

struct ArtistDO: Identifiable {
    let id: String
    let name: String
    let cover: URL?
}

@MainActor
@Observable
class HomeOO_MusicKit: ObservableObject { // Change to AlbumOO
    var recentlyAlbums: [AlbumDO] = []
    var popularAlbums: [AlbumDO] = []
    var artists: [ArtistDO] = []
    
    init() {
        Task {
            await requestMusicAuthorization()
        }
    }
    
    func requestMusicAuthorization() async {
        let status = await MusicAuthorization.request()
        if status == .authorized {
            await fetch()
        } else {
            print("Music authorization is not granted.")
        }
    }
    
    func fetch() async {
        await fetchPopularAlbums()
        await fetchRecentlyAlbums()
    }
    
    func checkMainThread() {
        print("Check main: \(Thread.isMainThread)")
    }
    
    private func fetchPopularAlbums() async {
        do {
            checkMainThread()// ✅ จะเป็น true
            let request = MusicCatalogSearchRequest(term: "Top Hits", types: [MusicKit.Album.self, MusicKit.Artist.self])
            let response = try await request.response()
            checkMainThread() // ✅ จะเป็น true (กลับมาที่ Main Thread)
            
            self.popularAlbums = response.albums.map { album in
                AlbumDO(
                    id: album.id.rawValue,
                    title: album.recordLabelName ?? "No album name",
                    description: album.editorialNotes?.standard ?? "No description",
                    artist: album.artistName,
                    cover: album.artwork?.url(width: 300, height: 300)
                )
            }
            
            self.artists = response.artists.map { artist in
                ArtistDO(
                    id: artist.id.rawValue,
                    name: artist.name,
                    cover: artist.artwork?.url(width: 300, height: 300)
                )
            }
        } catch {
            print("Failed to fetch popular albums: \(error)")
        }
    }
    
    private func fetchRecentlyAlbums() async {
        do {
            let request = MusicCatalogSearchRequest(term: "Recently", types: [MusicKit.Album.self])
            let response = try await request.response()
            
            self.recentlyAlbums = response.albums.map { album in
                AlbumDO(
                    id: album.id.rawValue,
                    title: album.recordLabelName ?? "No album name",
                    description: album.editorialNotes?.standard ?? "No description",
                    artist: album.artistName,
                    cover: album.artwork?.url(width: 300, height: 300)
                )
            }
        } catch {
            print("Failed to fetch recently albums: \(error)")
        }
    }
    
}
