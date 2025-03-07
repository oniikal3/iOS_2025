//
//  MockHomeOO.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 23/2/25.
//

import Foundation

@Observable
class MockHomeOO: HomeOO {
    
    override func fetch() async {
        print("fetch albums in mock data")
        fetchRecentlyAlbums()
        fetchPopularAlbums()
    }
    
    private func fetchRecentlyAlbums() {
        newReleaseAlbums = [
            AlbumDO(id: "1", title: "The Greatest Hits", description: "A collection of Queen's greatest hits.", artist: "Queen", cover: URL(string: "queen")),
            AlbumDO(id: "2", title: "The Best of Elton John", description: "A compilation of Elton John's best songs.", artist: "Elton John", cover: URL(string: "elton_john")),
            AlbumDO(id: "3", title: "The Best of Bee Gees", description: "The best hits from the Bee Gees.", artist: "Bee Gees", cover: URL(string: "bee_gees")),
            AlbumDO(id: "4", title: "The Best of ABBA", description: "ABBA's greatest hits compilation.", artist: "ABBA", cover: URL(string: "abba")),
            AlbumDO(id: "5", title: "The Best of The Carpenters", description: "A collection of The Carpenters' best songs.", artist: "The Carpenters", cover: URL(string: "the_carpenters"))
        ]
    }

    private func fetchPopularAlbums() {
        featuredPlaylists = [
            PlaylistDO(id: "1", name: "Top 50 Global", description: "The top 50 songs around the world.", image: URL(string: "top_50_global"), owner: "Spotify"),
            PlaylistDO(id: "2", name: "Top 50 Thailand", description: "The top 50 songs in Thailand.", image: URL(string: "top_50_thailand"), owner: "Spotify"),
            PlaylistDO(id: "3", name: "Top 50 UK", description: "The top 50 songs in the UK.", image: URL(string: "top_50_uk"), owner: "Spotify"),
            PlaylistDO(id: "4", name: "Top 50 US", description: "The top 50 songs in the US.", image: URL(string: "top_50_us"), owner: "Spotify"),
            PlaylistDO(id: "5", name: "Top 50 Japan", description: "The top 50 songs in Japan.", image: URL(string: "top_50_japan"), owner: "Spotify")
        ]
    }

}
