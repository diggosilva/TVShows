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
    
    private var state: Bindable<FeedViewControllerStates> = Bindable(value: .loading)
    private var shows: [Show] = []
    private var showsFiltered: [Show] = []
    private var page: Int = 0
    private var isLoading = false
    private var hasMorePages = true
    
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
        guard !isLoading, hasMorePages else { return }

        isLoading = true
        state.value = .loading

        service.getShows(page: page) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false

            switch result {
            case .success(let newShows):
                if newShows.isEmpty {
                    self.hasMorePages = false
                    return
                }

                self.page += 1
                self.shows.append(contentsOf: newShows)
                self.showsFiltered.append(contentsOf: newShows)
                self.state.value = .loaded
                self.state.value = .showsFiltered(self.showsFiltered)
                
                print("DEBUG: Carregando pagina \(self.page), com \(newShows.count) shows. TOTAL DE SHOWS: \(self.shows.count)")

            case .failure:
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
