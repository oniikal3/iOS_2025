//
//  SpotifyAPI+Track.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 7/3/25.
//

import Foundation

extension SpotifyAPI {

    func getTrack(for trackID: String) async throws -> TrackResponse {
        let details = try await getTrackDetails(for: trackID)
        let previewURL = try await getPreviewURL(for: trackID)
        
        return TrackResponse(
            id: details.id,
            name: details.name,
            preview_url: previewURL,
            artists: details.artists,
            album: details.album,
            duration_ms: details.duration_ms
        )
    }
    
    private func getTrackDetails(for trackID: String) async throws -> TrackResponse {
        let url = URL(string: "https://api.spotify.com/v1/tracks/\(trackID)")!
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

struct TrackResponse: Decodable {
    let id: String
    let name: String
    let preview_url: URL?
    let artists: [Artist]
    let album: Album
    let duration_ms: Int
}
