//
//  Service.swift
//  TVShows
//
//  Created by Diggo Silva on 23/03/25.
//

import Foundation

protocol ServiceProtocol {
    func getShows(page: Int) async throws -> [Show]
    func getCast(id: Int) async throws -> [Cast]
    func getSeasons(id: Int) async throws -> [Season]
    func getEpisodes(id: Int) async throws -> [Episode]
}

final class Service: ServiceProtocol {
    func getShows(page: Int) async throws -> [Show] {
        let showsResponse = try await fetchData(endpoint: .pagedShows(page: page), decodingType: [ShowsResponse].self)
        var shows: [Show] = []
        
        for show in showsResponse {
            let show = Show(id: show.id,
                            name: show.name,
                            mediumImage: show.image?.medium,
                            originalImage: show.image?.original,
                            rating: show.rating.average,
                            summary: show.summary)
            shows.append(show)
        }
        return shows
    }
    
    func getCast(id: Int) async throws -> [Cast] {
        let castResponse = try await fetchData(endpoint: .castForShow(id: id), decodingType: [CastResponse].self)
        var castList: [Cast] = []
        
        for cast in castResponse {
            let person = cast.person
            let cast = Cast(id: person.id,
                            name: person.name,
                            image: (medium: person.image?.medium, original: person.image?.original),
                            country: (name: person.name, code: person.country?.code),
                            birthday: person.birthday,
                            gender: person.gender)
            castList.append(cast)
        }
        return castList
    }
    
    func getSeasons(id: Int) async throws -> [Season] {
        let seasonResponse = try await fetchData(endpoint: .seasonsForShow(id: id), decodingType: [SeasonResponse].self)
        var seasons: [Season] = []
        
        for season in seasonResponse {
            let season = Season(id: season.id,
                                number: season.number,
                                image: (medium: season.image?.medium, original: season.image?.original),
                                episodes: season.episodeOrder)
            seasons.append(season)
        }
        return seasons
    }
    
    func getEpisodes(id: Int) async throws -> [Episode] {
        let episodesResponse = try await fetchData(endpoint: .episodesForShow(id: id), decodingType: [EpisodeResponse].self)
        var episodes: [Episode] = []
            
        for episode in episodesResponse {
            let episode = Episode(id: episode.id,
                                  name: episode.name,
                                  season: episode.season,
                                  number: episode.number,
                                  airdate: episode.airdate,
                                  airtime: episode.airtime,
                                  rating: episode.rating?.average,
                                  image: (medium: episode.image?.original, original: episode.image?.original),
                                  summary: episode.summary)
            episodes.append(episode)
        }
        return episodes
    }
    
    private func fetchData<T: Decodable>(endpoint: TVMazeEndpoint, decodingType: T.Type) async throws -> T {
        guard let url = createURL(for: endpoint) else {
            throw DSError.invalidData
        }
        
        let (data, response): (Data, URLResponse)
        
        do {
            (data, response) = try await URLSession.shared.data(from: url)
        } catch {
            throw DSError.networkError
        }
        
        guard (response as? HTTPURLResponse) != nil else {
            throw DSError.networkError
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw DSError.failedDecoding
        }
    }
    
    private func createURL(for endpoint: TVMazeEndpoint) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.tvmaze.com"
        urlComponents.path = endpoint.path
        
        if let queryItems = endpoint.queryItems {
            urlComponents.queryItems = queryItems
        }
        
//        print("DEBUG: URL: \(String(describing: urlComponents.url))")
        return urlComponents.url
    }
}
