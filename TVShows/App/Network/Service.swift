//
//  Service.swift
//  TVShows
//
//  Created by Diggo Silva on 23/03/25.
//

import Foundation

protocol ServiceProtocol {
    func getShows(page: Int, completion: @escaping(Result<[Show], DSError>) -> Void)
    func getCast(id: Int, completion: @escaping(Result<[Cast], DSError>) -> Void)
    func getSeasons(id: Int, completion: @escaping(Result<[Season], DSError>) -> Void)
    func getEpisodes(id: Int, completion: @escaping(Result<[Episode], DSError>) -> Void)
}

final class Service: ServiceProtocol {
    
    func getShows(page: Int, completion: @escaping(Result<[Show], DSError>) -> Void) {        
        guard let url = createURL(for: .page(page)) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if error != nil {
                    completion(.failure(.showsFailed))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.networkError))
                    return
                }
                
                print("DEBUG: Status code: \(response.statusCode)")
                
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                do {
                    let showsResponse = try JSONDecoder().decode([ShowsResponse].self, from: data)
                    var shows: [Show] = []
                    
                    for show in showsResponse {
                        let show = Show(id: show.id,
                                        name: show.name,
                                        image: show.image.medium, imageLarge: show.image.original,
                                        rating: show.rating.average)
                        shows.append(show)
                    }
                    completion(.success(shows))
                    
                } catch {
                    completion(.failure(.failedDecoding))
                }
            }
        }
        task.resume()
    }
    
    func getCast(id: Int, completion: @escaping(Result<[Cast], DSError>) -> Void) {
        guard let url = createURL(for: .cast(id)) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if error != nil {
                    completion(.failure(.castFailed))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.networkError))
                    return
                }
                
                print("DEBUG: Status code CAST: \(response.statusCode)")
                
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                do {
                    let castResponse = try JSONDecoder().decode([CastResponse].self, from: data)
                    var casts: [Cast] = []
                    
                    for cast in castResponse {                        
                        let cast = Cast(id: cast.person.id,
                                        name: cast.person.name,
                                        image: (cast.person.image.medium, cast.person.image.original),
                                        country: (cast.person.country?.name, cast.person.country?.code),
                                        birthday: cast.person.birthday,
                                        gender: cast.person.gender)
                        casts.append(cast)
                    }
                    completion(.success(casts))
                    print("DEBUG: CAST: \(casts)")
                    
                } catch {
//                    completion(.failure(.failedDecoding))
                    print("DEBUG: CAST ERROR: \(error)")
                }
            }
        }
        task.resume()
    }
    
    func getSeasons(id: Int, completion: @escaping(Result<[Season], DSError>) -> Void) {
        guard let url = createURL(for: .season(id)) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if error != nil {
                    completion(.failure(.seasonFailed))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.networkError))
                    return
                }
                
                print("DEBUG: Status code SEASON: \(response.statusCode)")
                
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                do {
                    let seasonResponse = try JSONDecoder().decode([SeasonResponse].self, from: data)
                    var seasons: [Season] = []
                    
                    for season in seasonResponse {
                        let season = Season(id: season.id,
                                            number: season.number,
                                            image: (season.image?.medium, season.image?.original),
                                            episodes: season.episodeOrder)
                        seasons.append(season)
                    }
                    completion(.success(seasons))
                    print("DEBUG: SEASON: \(seasons)")
                    
                } catch {
//                    completion(.failure(.failedDecoding))
                    print("DEBUG: SEASON ERROR: \(error)")
                }
            }
        }
        task.resume()
    }
    
    func getEpisodes(id: Int, completion: @escaping(Result<[Episode], DSError>) -> Void) {
        guard let url = createURL(for: .episodes(id)) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if error != nil {
                    completion(.failure(.episodeFailed))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.networkError))
                    return
                }
                
                print("DEBUG: Status code EPISODE: \(response.statusCode)")
                
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                do {
                    let episodeResponse = try JSONDecoder().decode([EpisodeResponse].self, from: data)
                    var episodes: [Episode] = []
                    
                    for episode in episodeResponse {
                        let episode = Episode(id: episode.id,
                                              name: episode.name,
                                              season: episode.season, number: episode.number,
                                              airdate: episode.airdate, airtime: episode.airtime,
                                              rating: episode.rating?.average,
                                              image: (episode.image?.medium, episode.image?.original),
                                              summary: episode.summary)
                        episodes.append(episode)
                    }
                    completion(.success(episodes))
                    print("DEBUG: EPISODES: \(episodes)")
                    
                } catch {
//                    completion(.failure(.failedDecoding))
                    print("DEBUG: EPISODE ERROR: \(error)")
                }
            }
        }
        task.resume()
    }
    
    private func createURL(for endpoint: TVMazeEndpoint) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.tvmaze.com"
        urlComponents.path = endpoint.path
        
        if let queryItems = endpoint.queryItems {
            urlComponents.queryItems = queryItems
        }
        
        print("DEBUG: URL: \(String(describing: urlComponents.url))")
        return urlComponents.url
    }
}
