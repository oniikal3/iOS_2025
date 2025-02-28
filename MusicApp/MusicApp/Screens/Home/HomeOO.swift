//
//  HomeOO.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 23/2/25.
//

import Foundation

@Observable
class HomeOO: ObservableObject { // Change to AlbumOO
    var recentlyAlbums: [AlbumDO] = []
    var popularAlbums: [AlbumDO] = []
    
    func fetch() {
        fetchRecentlyAlbums()
        fetchPopularAlbums()
    }
    
    private func fetchRecentlyAlbums() {
        recentlyAlbums = [
            AlbumDO(title: "The Greatest Hits", description: "A collection of Queen's greatest hits.", artist: "Queen", cover: "queen"),
            AlbumDO(title: "The Best of Elton John", description: "A compilation of Elton John's best songs.", artist: "Elton John", cover: "elton_john"),
            AlbumDO(title: "The Best of Bee Gees", description: "The best hits from the Bee Gees.", artist: "Bee Gees", cover: "bee_gees"),
            AlbumDO(title: "The Best of ABBA", description: "ABBA's greatest hits compilation.", artist: "ABBA", cover: "abba"),
            AlbumDO(title: "The Best of The Carpenters", description: "A collection of The Carpenters' best songs.", artist: "The Carpenters", cover: "the_carpenters")
        ]
    }

    private func fetchPopularAlbums() {
        popularAlbums = [
            AlbumDO(title: "The Best of The Beatles", description: "A compilation of The Beatles' greatest hits.", artist: "The Beatles", cover: "the_beatles"),
            AlbumDO(title: "The Best of The Rolling Stones", description: "The Rolling Stones' best songs collection.", artist: "The Rolling Stones", cover: "the_rolling_stones"),
            AlbumDO(title: "The Best of The Eagles", description: "A collection of The Eagles' greatest hits.", artist: "The Eagles", cover: "the_eagles"),
            AlbumDO(title: "The Best of The Doors", description: "The best hits from The Doors.", artist: "The Doors", cover: "the_doors"),
            AlbumDO(title: "The Best of The Who", description: "A compilation of The Who's greatest hits.", artist: "The Who", cover: "the_who")
        ]
    }
}
