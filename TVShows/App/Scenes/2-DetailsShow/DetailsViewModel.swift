//
//  DetailsViewModel.swift
//  TVShows
//
//  Created by Diggo Silva on 24/03/25.
//

import Foundation
import Combine

enum DetailsViewControllerStates {
    case loading
    case loaded
    case error
    case showAlert(title: String, message: String)
}

protocol DetailsViewModelProtocol: StatefulViewModel where State == DetailsViewControllerStates {
    func getShow() -> Show
    func numberOfItemsInSection() -> Int
    func castForItem(at indexPath: IndexPath) -> Cast
    func fetchCast()
    
    func numberOfSeasonsInSection() -> Int
    func seasonForItem(at indexPath: IndexPath) -> Season
    func fetchSeasons()
    
    func addShowToFavorite(show: Show, completion: @escaping(Result<String, DSError>) -> Void)
}

class DetailsViewModel: DetailsViewModelProtocol {

    private let show: Show
    private var casts: [Cast] = []
    private var seasons: [Season] = []
    
    private let service: ServiceProtocol
    private let repository: RepositoryProtocol
    
    @Published private var state: DetailsViewControllerStates = .loading
    
    var statePublisher: AnyPublisher<DetailsViewControllerStates, Never> {
        $state.eraseToAnyPublisher()
    }
        
    init(show: Show, service: ServiceProtocol = Service(), repository: RepositoryProtocol = Repository()) {
        self.show = show
        self.service = service
        self.repository = repository
    }
    
    func getShow() -> Show {
        return show
    }
    
    //MARK: CAST
    func numberOfItemsInSection() -> Int {
        return casts.count
    }
    
    func castForItem(at indexPath: IndexPath) -> Cast {
        return casts[indexPath.item]
    }
    
    func fetchCast() {
        state = .loading
        
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            
            do {
                let casts = try await service.getCast(id: show.id)
                self.casts.append(contentsOf: casts)
                state = .loaded
            } catch {
                state = .error
            }
        }
    }
    
    //MARK: SEASON
    func numberOfSeasonsInSection() -> Int {
        return seasons.count
    }
    
    func seasonForItem(at indexPath: IndexPath) -> Season {
        return seasons[indexPath.item]
    }
    
    func fetchSeasons() {
        state = .loading
        
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            
            do {
                let seasons = try await service.getSeasons(id: show.id)
                self.seasons.append(contentsOf: seasons)
                state = .loaded
            } catch {
                state = .error
            }
        }
    }
    
    //MARK: ADD SHOW TO FAVORITES
    func addShowToFavorite(show: Show, completion: @escaping(Result<String, DSError>) -> Void) {
        repository.saveShow(show) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.state = .showAlert(title: "Sucesso! ✅", message: "Série adicionada aos favoritos!")
                case .failure(let error):
                    self.state = .showAlert(title: "Ops... algo deu errado! ⛔️", message: error.rawValue)
                }
            }
        }
    }
}
