//
//  Repository.swift
//  TVShows
//
//  Created by Diggo Silva on 01/04/25.
//

import Foundation

protocol RepositoryProtocol {
    func getShows() -> [Show]
    func saveShow(_ show: Show, completion: @escaping(Result<String, DSError>) -> Void)
    func saveShows(_ shows: [Show])
}

class Repository: RepositoryProtocol {
    
    private let userDefault = UserDefaults.standard
    private let showKey = "showKey"
    
    func getShows() -> [Show] {
        if let data = userDefault.data(forKey: showKey) {
            if let decodedShows = try? JSONDecoder().decode([Show].self, from: data) {
                return decodedShows
            }
        }
        return []
    }
    
    func saveShow(_ show: Show, completion: @escaping(Result<String, DSError>) -> Void) {
        var savedShows = getShows()
        
        if savedShows.contains(where: { $0.id == show.id }) {
            completion(.failure(.showAlreadySaved))
            return
        }
        
        savedShows.append(show)
        
        if let encodedData = try? JSONEncoder().encode(savedShows) {
            userDefault.set(encodedData, forKey: showKey)
            completion(.success(show.name))
            return
        }
    }
    
    func saveShows(_ shows: [Show]) {
        if let encodedData = try? JSONEncoder().encode(shows) {
            userDefault.set(encodedData, forKey: showKey)
        }
    }
}
