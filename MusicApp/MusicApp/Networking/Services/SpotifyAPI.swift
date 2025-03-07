//
//  SpotifyAPI.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 5/3/25.
//

import Foundation

struct AccessTokenResponse: Decodable {
    let access_token: String
    let token_type: String
    let expires_in: Int
//    let scope: String
//    let refresh_token: String
}

class SpotifyAPI {
    static let shared = SpotifyAPI()
    
    private let clientID = "ef7b65812da04ff7947a79f4de6ad138"
    private let clientSecret = "91752af48d3e4bdea24f6d1a3965e65d"
    
    private var accessToken: String? {
        get {
            UserDefaults.standard.string(forKey: "spotify_access_token")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "spotify_access_token")
        }
    }
    
    private var expirationDate: Date? {
        get {
            UserDefaults.standard.object(forKey: "spotify_token_expiration_date") as? Date
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "spotify_token_expiration_date")
        }
    }
    
    private init() {}
    
    private func fetchAccessToken() async throws -> AccessTokenResponse {
        let url = URL(string: "https://accounts.spotify.com/api/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let body = "grant_type=client_credentials"
        request.httpBody = body.data(using: .utf8)
        let basicAuth = "\(clientID):\(clientSecret)"
        let basicAuthData = basicAuth.data(using: .utf8)!.base64EncodedString()
        request.setValue("Basic \(basicAuthData)", forHTTPHeaderField: "Authorization")
        
        print("Request: \(request)")
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(AccessTokenResponse.self, from: data)
        print("Access Token: \(response.access_token)")
        return response
    }
    
    private func ensureValidAccessToken() async throws -> String {
        if let token = accessToken, let expirationDate = expirationDate, expirationDate > Date() {
            print("Using existing token: \(token)")
            return token // ถ้ามี Token และยังไม่หมดอายุ
        }
        
        let response = try await fetchAccessToken()
        // print token and expiration date
        print("Token: \(response.access_token)")
        print("Expiration Date: \(Date().addingTimeInterval(TimeInterval(response.expires_in)))")
        accessToken = response.access_token
        expirationDate = Date().addingTimeInterval(TimeInterval(response.expires_in))
        return response.access_token
    }
    
    internal func request<T: Decodable>(url: URL) async throws -> T {
        let token = try await ensureValidAccessToken()
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        print("Request: \(request)")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        // print data into jsonstring
        let jsonString = String(data: data, encoding: .utf8)!
        print("Data: \(jsonString)")
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func getFeaturedPlaylists() async throws -> FeaturedPlaylistsResponse {
//        let url = URL(string: "https://api.spotify.com/v1/browse/featured-playlists?country=US")! // Endpoint deprecated
//        return try await request(url: url)
        let url = URL(string: "https://api.spotify.com/v1/search?q=featured&type=playlist&limit=10")!
        return try await request(url: url)
    }
    
    func getNewReleases() async throws -> NewReleasesResponse {
        let url = URL(string: "https://api.spotify.com/v1/browse/new-releases")!
        return try await request(url: url)
    }
    
    // Get Top-Hits Artist
    func getTopHitsArtist() async throws -> TopHitsArtistResponse {
        let url = URL(string: "https://api.spotify.com/v1/search?q=Top%20Hits&type=artist")!
        return try await request(url: url)
    }
    
}

extension SpotifyAPI {
    func getPlaylistDetails(for id: String) async throws -> PlaylistDetailsResponse {
        let url = URL(string: "https://api.spotify.com/v1/playlists/\(id)")!
        return try await request(url: url)
    }
}
// Playlist Details
struct PlaylistDetailsResponse: Decodable {
    let name: String
    let description: String
    let images: [SPTImage]
    let owner: Owner
    let tracks: Tracks
}

struct Tracks: Decodable {
    let items: [Track]
    let total: Int
}

struct Track: Decodable {
    let track: TrackItem
}

struct TrackItem: Decodable {
    let id: String
    let name: String
//    let preview_url: URL?
    let artists: [Artist]
    let album: Album
    let duration_ms: Int
}

// Top-Hits Artist
struct TopHitsArtistResponse: Decodable {
    let artists: Artists
}

struct Artists: Decodable {
    let items: [Artist]
}

// Albums
struct NewReleasesResponse: Decodable {
    let albums: Albums
}

struct Albums: Decodable {
    let items: [Album]
    let total: Int
}

struct Album: Decodable {
    let id: String
    let name: String
    let images: [SPTImage]
    let artists: [Artist]
}

struct Artist: Decodable {
    let name: String
    let id: String
    let images: [SPTImage]? // Optional
}

// Featured Playlists
struct FeaturedPlaylistsResponse: Decodable {
    let message: String?
    let playlists: Playlists
}

struct Playlists: Decodable {
    let items: [Playlist]
    let total: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        total = try container.decode(Int.self, forKey: .total)
        
        // Decode items array and filter out null values
        let itemsArr = try container.decode([Playlist?].self, forKey: .items)
        items = itemsArr.compactMap { $0 }
    }
    
    enum CodingKeys: String, CodingKey {
        case items
        case total
    }
}

struct Playlist: Decodable {
    let id: String
    let name: String
    let images: [SPTImage]
    let description: String
    let owner: Owner
}

struct Owner: Decodable {
    let display_name: String
    let id: String
}

struct SPTImage: Decodable {
    let url: URL?
    let width: Int?
    let height: Int?
}
