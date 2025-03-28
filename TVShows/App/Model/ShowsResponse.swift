//
//  ShowsResponse.swift
//  TVShows
//
//  Created by Diggo Silva on 23/03/25.
//

import Foundation

// MARK: - ShowsResponse
struct ShowsResponse: Codable {
    let id: Int
    let url: String
    let name: String
    let averageRuntime: Int
    let rating: Rating
    let image: Image

    enum CodingKeys: String, CodingKey {
        case id, url, name, averageRuntime, rating, image
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
