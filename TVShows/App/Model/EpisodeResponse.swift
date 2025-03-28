//
//  EpisodeResponse.swift
//  TVShows
//
//  Created by Diggo Silva on 27/03/25.
//

import Foundation

// MARK: - EpisodeResponseElement
struct EpisodeResponse: Codable {
    let id: Int
    let name: String
    let number: Int
    let airdate: String
    let airtime: String
    let rating: Rating?
    let image: Image?
    let summary: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, number, airdate, airtime, rating, image, summary
    }
    
    // MARK: - Image
    struct Image: Codable {
        let medium, original: String
    }
    
    // MARK: - Rating
    struct Rating: Codable {
        let average: Double?
    }
}
