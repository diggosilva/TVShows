//
//  CastResponse.swift
//  TVShows
//
//  Created by Diggo Silva on 24/03/25.
//

import Foundation

// MARK: - CastResponse
struct CastResponse: Codable {
    let person: Person

    // MARK: - Image
    struct Image: Codable {
        let medium, original: String
    }

    // MARK: - Person
    struct Person: Codable {
        let id: Int
        let url: String
        let name: String
        let country: Country?
        let birthday: String?
        let gender: String?
        let image: Image?
    }

    // MARK: - Country
    struct Country: Codable {
        let name: String
        let code: String
    }
}
