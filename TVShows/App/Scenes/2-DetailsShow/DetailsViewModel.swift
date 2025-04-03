//
//  DetailsViewModel.swift
//  TVShows
//
//  Created by Diggo Silva on 24/03/25.
//

import Foundation

enum DetailsViewControllerStates {
    case loading
    case loaded
    case error
    case showAlert(title: String, message: String)
}

protocol DetailsViewModelProtocol {
    var state: Bindable<DetailsViewControllerStates> { get }
    
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

    private(set) var state: Bindable<DetailsViewControllerStates> = Bindable(value: .loading)
    private let show: Show
    private var casts: [Cast] = []
    private var seasons: [Season] = []
    
    private let service: ServiceProtocol
    private let repository: RepositoryProtocol
        
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
        state.value = .loading
        
        service.getCast(id: show.id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let casts):
                self.casts.append(contentsOf: casts)
                state.value = .loaded
                
            case .failure(let error):
                print("DEBUG: Error \(error.rawValue)")
                state.value = .error
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
        state.value = .loading
        
        service.getSeasons(id: show.id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let seasons):
                self.seasons.append(contentsOf: seasons)
                state.value = .loaded
                
            case .failure(let error):
                print("DEBUG: Error \(error.rawValue)")
                state.value = .error
            }
        }
    }
    
    //MARK: ADD SHOW TO FAVORITES
    func addShowToFavorite(show: Show, completion: @escaping(Result<String, DSError>) -> Void) {
        repository.saveShow(show) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.state.value = .showAlert(title: "Sucesso! 🎉", message: "Série adicionada aos favoritos!")
                case .failure(let error):
                    self.state.value = .showAlert(title: "Ops... algo deu errado! 😅", message: error.rawValue)
                }
            }
        }
    }
}
