//
//  APIManager.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 28/2/25.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    
    func request<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data) // Decoding data into model
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
}
