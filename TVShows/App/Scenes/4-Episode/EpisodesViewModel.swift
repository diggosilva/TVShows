//
//  EpisodesViewModel.swift
//  TVShows
//
//  Created by Diggo Silva on 27/03/25.
//

import Foundation

enum EpisodesViewControllerStates {
    case loading
    case loaded
    case error
}

protocol EpisodesViewModelProtocol {
    func numberOfRowsInSection() -> Int
    func cellForRow(at indexPath: IndexPath) -> Episode
    func fetchEpisodes()
}

class EpisodesViewModel: EpisodesViewModelProtocol {
    private(set) var state: Bindable<EpisodesViewControllerStates> = Bindable(value: .loading)
    
    private var show: Show!
    private var season: Int
    private var episodes: [Episode] = []
    private let service: ServiceProtocol
    
    init(show: Show, season: Int, service: ServiceProtocol = Service()) {
        self.service = service
        self.show = show
        self.season = season
    }
    
    func numberOfRowsInSection() -> Int {
        return episodes.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> Episode {
        return episodes[indexPath.row]
    }
    
    func fetchEpisodes() {
        state.value = .loading
        
        service.getEpisodes(id: show.id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let episodes):
                self.episodes.append(contentsOf: episodes)
                self.episodes = episodes.filter({ $0.season == self.season })
                state.value = .loaded
                
            case .failure(let error):
                print("Error: \(error.rawValue)")
                state.value = .error
            }
        }
    }
}
