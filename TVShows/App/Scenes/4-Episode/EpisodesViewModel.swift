//
//  EpisodesViewModel.swift
//  TVShows
//
//  Created by Diggo Silva on 27/03/25.
//

import Foundation
import Combine

enum EpisodesViewControllerStates {
    case loading
    case loaded
    case error
}

protocol EpisodesViewModelProtocol: StatefulViewModel where State == EpisodesViewControllerStates {
    func numberOfRowsInSection() -> Int
    func cellForRow(at indexPath: IndexPath) -> Episode
    func fetchEpisodes()
}

class EpisodesViewModel: EpisodesViewModelProtocol {
   
    private var show: Show!
    private var season: Int
    private var episodes: [Episode] = []
    private let service: ServiceProtocol
    @Published private var state: EpisodesViewControllerStates = .loading
    
    var statePublisher: AnyPublisher<EpisodesViewControllerStates, Never> {
        $state.eraseToAnyPublisher()
    }
    
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
        state = .loading
        
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            
            do {
                let episodes = try await service.getEpisodes(id: show.id)
                self.episodes.append(contentsOf: episodes)
                self.episodes = episodes.filter({ $0.season == self.season })
                state = .loaded
            } catch {
                state = .error
            }
        }
    }
}
