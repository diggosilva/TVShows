//
//  FavoritesViewModel.swift
//  TVShows
//
//  Created by Diggo Silva on 01/04/25.
//

import Foundation

protocol FavoritesViewModelProtocol {
    var shows: [Show] { get set }
    var delegate: FavoritesViewModelDelegate? { get set }
    
//    func getShows() -> [Show]
    func numberOfRowsInSection() -> Int
    func cellForRow(at indexPath: IndexPath) -> Show
    func loadShows()
    func saveShows()
}

protocol FavoritesViewModelDelegate: AnyObject {
    func reloadTable()
}

class FavoritesViewModel: FavoritesViewModelProtocol {
    
    var shows: [Show] = []
    private let repository: RepositoryProtocol
    
    weak var delegate: FavoritesViewModelDelegate?
    
    init(repository: RepositoryProtocol = Repository()) {
        self.repository = repository
        loadShows()
    }
    
//    func getShows() -> [Show] {
//        return shows
//    }
    
    func numberOfRowsInSection() -> Int {
        shows.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> Show {
        return shows[indexPath.row]
    }
    
    func loadShows() {
        shows = repository.getShows()
        delegate?.reloadTable()
    }
    
    func saveShows() {
        repository.saveShows(shows)
    }
}
