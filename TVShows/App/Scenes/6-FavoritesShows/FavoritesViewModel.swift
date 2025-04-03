//
//  FavoritesViewModel.swift
//  TVShows
//
//  Created by Diggo Silva on 01/04/25.
//

import Foundation

protocol FavoritesViewModelDelegate: AnyObject {
    func reloadTable()
}

protocol FavoritesViewModelProtocol {
    func numberOfRowsInSection() -> Int
    func cellForRow(at indexPath: IndexPath) -> Show
    func loadShows()
    func saveShows()
    func removeShow(at index: Int)
    func setDelegate(_ delegate: FavoritesViewModelDelegate)
}

class FavoritesViewModel: FavoritesViewModelProtocol {
    
    private var shows: [Show] = []
    private let repository: RepositoryProtocol
    
    weak var delegate: FavoritesViewModelDelegate?
    
    init(repository: RepositoryProtocol = Repository()) {
        self.repository = repository
        loadShows()
    }
    
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
    
    func removeShow(at index: Int) {
        shows.remove(at: index)
    }
    
    func setDelegate(_ delegate: FavoritesViewModelDelegate) {
        self.delegate = delegate
    }
}
