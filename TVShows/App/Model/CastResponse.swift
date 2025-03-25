//
//  CastResponse.swift
//  TVShows
//
//  Created by Diggo Silva on 24/03/25.
//

import Foundation

// MARK: - CastResponseElement
struct CastResponse: Codable {
    let person: Person
    let character: Character
    let castResponseSelf, voice: Bool

    enum CodingKeys: String, CodingKey {
        case person, character
        case castResponseSelf = "self"
        case voice
    }
    
    // MARK: - Character
    struct Character: Codable {
        let id: Int
        let url: String
        let name: String
        let image: Image?
        let links: Links

        enum CodingKeys: String, CodingKey {
            case id, url, name, image
            case links = "_links"
        }
    }

    // MARK: - Image
    struct Image: Codable {
        let medium, original: String
    }

    // MARK: - Links
    struct Links: Codable {
        let linksSelf: SelfClass

        enum CodingKeys: String, CodingKey {
            case linksSelf = "self"
        }
    }

    // MARK: - SelfClass
    struct SelfClass: Codable {
        let href: String
    }

    // MARK: - Person
    struct Person: Codable {
        let id: Int
        let url: String
        let name: String
        let country: Country
        let birthday: String?
        let deathday: JSONNull?
        let gender: Gender
        let image: Image
        let updated: Int
        let links: Links

        enum CodingKeys: String, CodingKey {
            case id, url, name, country, birthday, deathday, gender, image, updated
            case links = "_links"
        }
    }

    // MARK: - Country
    struct Country: Codable {
        let name: Name
        let code: Code
        let timezone: Timezone
    }

    enum Code: String, Codable {
        case ca = "CA"
        case gb = "GB"
        case us = "US"
    }

    enum Name: String, Codable {
        case canada = "Canada"
        case unitedKingdom = "United Kingdom"
        case unitedStates = "United States"
    }

    enum Timezone: String, Codable {
        case americaNewYork = "America/New_York"
        case americaToronto = "America/Toronto"
        case europeLondon = "Europe/London"
    }

    enum Gender: String, Codable {
        case female = "Female"
        case male = "Male"
    }
    
    // MARK: - Encode/decode helpers

    class JSONNull: Codable, Hashable {

        public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
                return true
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(0)
        }

        public init() {}

        public required init(from decoder: Decoder) throws {
                let container = try decoder.singleValueContainer()
                if !container.decodeNil() {
                        throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
                }
        }

        public func encode(to encoder: Encoder) throws {
                var container = encoder.singleValueContainer()
                try container.encodeNil()
        }
    }
}
