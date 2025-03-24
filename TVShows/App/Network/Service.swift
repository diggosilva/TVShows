//
//  Service.swift
//  TVShows
//
//  Created by Diggo Silva on 23/03/25.
//

import Foundation

protocol ServiceProtocol {
    func getShows(page: Int, completion: @escaping(Result<[Show], DSError>) -> Void)
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
                                        image: show.image.medium,
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
    
    private func createURL(for endpoint: TVMazeEndpoint) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.tvmaze.com"
        urlComponents.path = endpoint.path
        
        if let queryItems = endpoint.queryItems {
            urlComponents.queryItems = queryItems
        }
        
        print("DEBUG URL: \(String(describing: urlComponents.url))")
        return urlComponents.url
    }
}

enum TVMazeEndpoint {
    case shows(String)
    case page(Int)
    
    var path: String {
        switch self {
        case .shows(_):
            return "/shows"
       
        case .page(_):
            return "/shows"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .shows(_):
            return nil
        case .page(let page):
            return [URLQueryItem(name: "page", value: "\(page)")]
        }
    }
}
