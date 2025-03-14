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
}
