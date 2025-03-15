//
//  SpotifyAPI.swift
//  MoodyMusic
//
//  Created by Nathapong Masathien on 9/3/25.
//

import Foundation

class SpotifyAPI {
    static let shared = SpotifyAPI() // Singleton object
    
    private let clientID = "ef7b65812da04ff7947a79f4de6ad138"
    private let clientSecret = "91752af48d3e4bdea24f6d1a3965e65d"
    
    private var accessToken: String?
    
    func fetchAccessToken() async throws -> AccessTokenResponse {
        let url = URL(string: "https://accounts.spotify.com/api/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let body = "grant_type=client_credentials"
        request.httpBody = body.data(using: .utf8)
        let basicAuth = "\(clientID):\(clientSecret)"
        let basicAuthData = basicAuth.data(using: .utf8)!.base64EncodedString()
        request.setValue("Basic \(basicAuthData)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request) //ยิง request และได้ data กลับมา
        let response = try JSONDecoder().decode(AccessTokenResponse.self, from: data)
        print("Access Token: \(response.access_token)")
        return response
    }
    
    private func request<T: Decodable>(url: URL) async throws -> T {
        let token = try await fetchAccessToken()
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token.access_token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        if let string = String(data: data, encoding: .utf8) {
            print("Response: \(string)")
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func getChillPlaylists() async throws -> PlaylistsResponse {
        let url = URL(string: "https://api.spotify.com/v1/search?q=chill&type=playlist")!
        let response: PlaylistsResponse = try await request(url: url)
        return response
    }
    
    func getPlaylistDetails(for playlistID: String) async throws -> PlaylistDetailsResponse {
        let url = URL(string: "https://api.spotify.com/v1/playlists/\(playlistID)")!
        return try await request(url: url)
    }
    
    func getTrack(for trackId: String) async throws -> TrackResponse {
        let details = try await getTrackDetails(for: trackId)
        let previewURL = try await getPreviewURL(for: trackId)
        
        return TrackResponse(
            id: details.id,
            name: details.name,
            preview_url: previewURL,
            artists: details.artists,
            album: details.album,
            duration_ms: details.duration_ms
        )
    }
    
    private func getTrackDetails(for trackId: String) async throws -> TrackResponse {
        let url = URL(string: "https://api.spotify.com/v1/tracks/\(trackId)")!
        return try await request(url: url)
    }
    
    private func getPreviewURL(for trackID: String) async throws -> URL? {
        guard let embedURL = URL(string: "https://open.spotify.com/embed/track/\(trackID)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: embedURL)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        guard let htmlString = String(data: data, encoding: .utf8) else {
            throw URLError(.cannotDecodeRawData)
        }
        
//        return extractPreviewURL(from: htmlString)
        guard let previewURL = extractPreviewURL(from: htmlString) else {
            throw URLError(.cannotDecodeRawData)
        }
        
        let url = previewURL.removingPercentEncoding?
            .trimmingCharacters(in: .whitespacesAndNewlines)
//            .replacingOccurrences(of: "\\\"", with: "")
        return URL(string: url ?? "")
    }
    
    private func extractPreviewURL(from htmlString: String) -> String? {
        let pattern = #"https://p.scdn.co/mp3-preview/[a-zA-Z0-9]+"#
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return nil
        }
        
        let matches = regex.matches(in: htmlString, range: NSRange(htmlString.startIndex..., in: htmlString))
        guard let match = matches.first else {
            return nil
        }
        
        guard let range = Range(match.range, in: htmlString) else {
            return nil
        }
        
        return String(htmlString[range])
    }
        
}
