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
        fetchData(endpoint: .pagedShows(page: page), decodingType: [ShowsResponse].self) { result in
            switch result {
            case .success(let showsResponse):
                let shows = showsResponse.map { show in
                    Show(id: show.id, name: show.name, image: show.image.medium, imageLarge: show.image.original, rating: show.rating.average, summary: show.summary)
                }
                completion(.success(shows))
            case .failure(_):
                completion(.failure(.showsFailed))
            }
        }
    }
    
    func getCast(id: Int, completion: @escaping(Result<[Cast], DSError>) -> Void) {
        fetchData(endpoint: .castForShow(id: id), decodingType: [CastResponse].self) { result in
            switch result {
            case .success(let castsResponse):
                let casts = castsResponse.map { cast in
                    Cast(id: cast.person.id, name: cast.person.name, image: (medium: cast.person.image.medium, original: cast.person.image.original), country: (name: cast.person.country?.name, code: cast.person.country?.code), birthday: cast.person.birthday, gender: cast.person.gender)
                }
                completion(.success(casts))
            case .failure(_):
                completion(.failure(.castFailed))
            }
        }
    }

    func getSeasons(id: Int, completion: @escaping(Result<[Season], DSError>) -> Void) {
        fetchData(endpoint: .seasonsForShow(id: id), decodingType: [SeasonResponse].self) { result in
            switch result {
            case .success(let seasonsResponse):
                let seasons = seasonsResponse.map { season in
                    Season(id: season.id, number: season.number, image: (medium: season.image?.medium, original: season.image?.original), episodes: season.episodeOrder)
                }
                completion(.success(seasons))
            case .failure(_):
                completion(.failure(.seasonFailed))
            }
        }
    }
    
    func getEpisodes(id: Int, completion: @escaping(Result<[Episode], DSError>) -> Void) {
        fetchData(endpoint: .episodesForShow(id: id), decodingType: [EpisodeResponse].self) { result in
            switch result {
            case .success(let episodesResponse):
                let episodes = episodesResponse.map { episode in
                    Episode(id: episode.id, name: episode.name, season: episode.season, number: episode.number, airdate: episode.airdate, airtime: episode.airtime, rating: episode.rating?.average, image: (medium: episode.image?.medium, original: episode.image?.original), summary: episode.summary)
                }
                completion(.success(episodes))
            case .failure(_):
                completion(.failure(.episodeFailed))
            }
        }
    }
    
    private func fetchData<T: Decodable>(endpoint: TVMazeEndpoint, decodingType: T.Type, completion: @escaping(Result<T, DSError>) -> Void) {
        guard let url = createURL(for: endpoint) else {
            completion(.failure(.invalidData))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("DEBUG: Erro ao fazer a requisição: \(error)")
                    completion(.failure(.networkError))
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
                    let decodedResponse = try JSONDecoder().decode(decodingType, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    print("DEBUG: Erro ao decodificar os dados: \(error)")
                    completion(.failure(.failedDecoding))
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
        
//        print("DEBUG: URL: \(String(describing: urlComponents.url))")
        return urlComponents.url
    }
}
