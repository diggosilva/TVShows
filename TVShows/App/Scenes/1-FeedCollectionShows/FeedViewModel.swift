//
//  FeedViewModel.swift
//  TVShows
//
//  Created by Diggo Silva on 23/03/25.
//

import Foundation

enum FeedViewControllerStates {
    case loading
    case loaded
    case error
    case showsFiltered([Show])
}

protocol FeedViewModelProtocol {
    func numberOfItemsInSection() -> Int
    func cellForItem(at indexPath: IndexPath) -> Show
    func searchBar(textDidChange searchText: String)
    func fetchShows()
    func observeState(_ observer: @escaping(FeedViewControllerStates) -> Void)
}

class FeedViewModel: FeedViewModelProtocol {
    
    private(set) var state: Bindable<FeedViewControllerStates> = Bindable(value: .loading)
    private(set) var shows: [Show] = []
    private(set) var showsFiltered: [Show] = []
    
    var page: Int = 0
    
    let service: ServiceProtocol
    
    init(service: ServiceProtocol = Service()) {
        self.service = service
    }
    
    func numberOfItemsInSection() -> Int {
        return showsFiltered.count
    }
    
    func cellForItem(at indexPath: IndexPath) -> Show {
        return showsFiltered[indexPath.item]
    }
    
    func searchBar(textDidChange searchText: String) {
        if searchText.isEmpty {
            showsFiltered = shows
        } else {
            showsFiltered = shows.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        updateState(.showsFiltered(showsFiltered))
    }
    
    func fetchShows() {
        state.value = .loading
        
        service.getShows(page: page) { [weak self] result in
            guard let self = self else { return }
           
            switch result {
            case .success(let shows):
                self.shows.append(contentsOf: shows)
                self.showsFiltered.append(contentsOf: shows)
                self.state.value = .loaded
                self.state.value = .showsFiltered(self.showsFiltered)
                
            case .failure(let error):
                print("Error: \(error.rawValue)")
                self.state.value = .error
            }
        }
    }
    
    private func updateState(_ newState: FeedViewControllerStates) {
        state.value = newState
    }
    
    func observeState(_ observer: @escaping(FeedViewControllerStates) -> Void) {
        state.bind(observer: observer)
    }
}
