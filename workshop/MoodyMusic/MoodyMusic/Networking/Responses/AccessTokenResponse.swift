//
//  AccessTokenResponse.swift
//  MoodyMusic
//
//  Created by Nathapong Masathien on 9/3/25.
//

import Foundation

struct AccessTokenResponse: Decodable {
    let access_token: String
    let expires_in: Int
}
    
