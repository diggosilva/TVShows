//
//  ShowsResponse.swift
//  TVShows
//
//  Created by Diggo Silva on 23/03/25.
//

import Foundation

// MARK: - ShowsResponseElement
struct ShowsResponse: Codable {
    let id: Int
    let url: String
    let name: String
    let type: TypeEnum
    let language: Language
    let genres: [Genre]
    let status: Status
    let runtime: Int?
    let averageRuntime: Int
    let premiered: String
    let ended: String?
    let officialSite: String?
    let schedule: Schedule
    let rating: Rating
    let weight: Int
    let network, webChannel: Network?
    let dvdCountry: Country?
    let externals: Externals
    let image: Image
    let summary: String
    let updated: Int
    let links: Links

    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, averageRuntime, premiered, ended, officialSite, schedule, rating, weight, network, webChannel, dvdCountry, externals, image, summary, updated
        case links = "_links"
    }
    
    // MARK: - Country
    struct Country: Codable {
        let name: Name
        let code: Code
        let timezone: Timezone
    }

    enum Code: String, Codable {
        case ca = "CA"
        case de = "DE"
        case fr = "FR"
        case gb = "GB"
        case jp = "JP"
        case us = "US"
    }

    enum Name: String, Codable {
        case canada = "Canada"
        case france = "France"
        case germany = "Germany"
        case japan = "Japan"
        case unitedKingdom = "United Kingdom"
        case unitedStates = "United States"
    }

    enum Timezone: String, Codable {
        case americaNewYork = "America/New_York"
        case americaToronto = "America/Toronto"
        case asiaTokyo = "Asia/Tokyo"
        case europeBusingen = "Europe/Busingen"
        case europeLondon = "Europe/London"
        case europeParis = "Europe/Paris"
    }

    // MARK: - Externals
    struct Externals: Codable {
        let tvrage: Int
        let thetvdb: Int?
        let imdb: String?
    }

    enum Genre: String, Codable {
        case action = "Action"
        case adventure = "Adventure"
        case anime = "Anime"
        case comedy = "Comedy"
        case crime = "Crime"
        case drama = "Drama"
        case espionage = "Espionage"
        case family = "Family"
        case fantasy = "Fantasy"
        case history = "History"
        case horror = "Horror"
        case legal = "Legal"
        case medical = "Medical"
        case music = "Music"
        case mystery = "Mystery"
        case romance = "Romance"
        case scienceFiction = "Science-Fiction"
        case sports = "Sports"
        case supernatural = "Supernatural"
        case thriller = "Thriller"
        case war = "War"
        case western = "Western"
    }

    // MARK: - Image
    struct Image: Codable {
        let medium, original: String
    }

    enum Language: String, Codable {
        case english = "English"
        case japanese = "Japanese"
    }

    // MARK: - Links
    struct Links: Codable {
        let linksSelf: SelfClass
        let previousepisode: Episode
        let nextepisode: Episode?

        enum CodingKeys: String, CodingKey {
            case linksSelf = "self"
            case previousepisode, nextepisode
        }
    }

    // MARK: - SelfClass
    struct SelfClass: Codable {
        let href: String
    }

    // MARK: - Episode
    struct Episode: Codable {
        let href: String
        let name: String
    }

    // MARK: - Network
    struct Network: Codable {
        let id: Int
        let name: String
        let country: Country?
        let officialSite: String?
    }

    // MARK: - Rating
    struct Rating: Codable {
        let average: Double?
    }

    // MARK: - Schedule
    struct Schedule: Codable {
        let time: Time
        let days: [Day]
    }

    enum Day: String, Codable {
        case friday = "Friday"
        case monday = "Monday"
        case saturday = "Saturday"
        case sunday = "Sunday"
        case thursday = "Thursday"
        case tuesday = "Tuesday"
        case wednesday = "Wednesday"
    }

    enum Time: String, Codable {
        case empty = ""
        case the0900 = "09:00"
        case the1200 = "12:00"
        case the1300 = "13:00"
        case the2000 = "20:00"
        case the2030 = "20:30"
        case the2100 = "21:00"
        case the2130 = "21:30"
        case the2200 = "22:00"
        case the2230 = "22:30"
        case the2300 = "23:00"
        case the2330 = "23:30"
    }

    enum Status: String, Codable {
        case ended = "Ended"
        case running = "Running"
        case toBeDetermined = "To Be Determined"
    }

    enum TypeEnum: String, Codable {
        case animation = "Animation"
        case documentary = "Documentary"
        case reality = "Reality"
        case scripted = "Scripted"
        case talkShow = "Talk Show"
    }

}

