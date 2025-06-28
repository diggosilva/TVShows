//
//  FeedViewModel.swift
//  TVShows
//
//  Created by Diggo Silva on 23/03/25.
//

import Foundation
import Combine

enum FeedViewControllerStates: Equatable {
    case loading
    case loaded
    case error
    case showsFiltered([Show])
}

protocol FeedViewModelProtocol: StatefulViewModel where State == FeedViewControllerStates {
    func numberOfItemsInSection() -> Int
    func cellForItem(at indexPath: IndexPath) -> Show
    func searchBar(textDidChange searchText: String)
    func fetchShows()
}

class FeedViewModel: FeedViewModelProtocol {
    
    private var shows: [Show] = []
    private var showsFiltered: [Show] = []
    private var page: Int = 0
    private var isLoading = false
    private var hasMorePages = true
    private var isSearching = false
    
    @Published private var state: FeedViewControllerStates = .loading
    
    var statePublisher: AnyPublisher<FeedViewControllerStates, Never> {
        $state.eraseToAnyPublisher()
    }
    
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
            isSearching = false
            showsFiltered = shows
        } else {
            isSearching = true
            showsFiltered = shows.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        updateState(.showsFiltered(showsFiltered))
    }
    
    func fetchShows() {
        guard !isLoading, !isSearching, hasMorePages else { return }

        isLoading = true
        state = .loading
        
        Task { @MainActor in
            
            do {
                let newShows = try await service.getShows(page: page)
                if newShows.isEmpty {
                    hasMorePages = false
                    isLoading = false
                    return
                }
                self.page += 1
                self.shows.append(contentsOf: newShows)
                self.showsFiltered.append(contentsOf: newShows)
                self.state = .loaded
                self.state = .showsFiltered(self.showsFiltered)
                print("DEBUG: Carregando pagina \(self.page), com \(newShows.count) shows. TOTAL DE SHOWS: \(self.shows.count)")
            } catch {
                self.state = .error
            }
            self.isLoading = false
        }
    }
    
    private func updateState(_ newState: FeedViewControllerStates) {
        state = newState
    }
}
