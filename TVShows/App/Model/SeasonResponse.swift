//
//  SeasonResponse.swift
//  TVShows
//
//  Created by Diggo Silva on 24/03/25.
//

import Foundation

// MARK: - SeasonResponse
struct SeasonResponse: Codable {
    let id: Int
    let number: Int
    let name: String
    let episodeOrder: Int?
    let image: Image?

    enum CodingKeys: String, CodingKey {
        case id, number, name, episodeOrder, image
    }
    
    // MARK: - Image
    struct Image: Codable {
        let medium, original: String?
    }
}
