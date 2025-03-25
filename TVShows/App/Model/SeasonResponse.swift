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
    let url: String
    let number: Int
    let name: String
    let episodeOrder: Int
    let premiereDate, endDate: String
    let network: Network
    let webChannel: JSONNull?
    let image: Image
    let summary: String
    let links: Links

    enum CodingKeys: String, CodingKey {
        case id, url, number, name, episodeOrder, premiereDate, endDate, network, webChannel, image, summary
        case links = "_links"
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

    // MARK: - Network
    struct Network: Codable {
        let id: Int
        let name: String
        let country: Country
        let officialSite: String
    }

    // MARK: - Country
    struct Country: Codable {
        let name, code, timezone: String
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
