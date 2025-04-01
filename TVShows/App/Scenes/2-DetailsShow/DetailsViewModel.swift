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
}

protocol DetailsViewModelProtocol {
    var state: Bindable<DetailsViewControllerStates> { get }
    var show: Show { get }
    var casts: [Cast] { get }
    var seasons: [Season] { get }
    
    func numberOfItemsInSection() -> Int
    func castForItem(at indexPath: IndexPath) -> Cast
    func fetchCast()
    
    func numberOfSeasonsInSection() -> Int
    func seasonForItem(at indexPath: IndexPath) -> Season
    func fetchSeasons()
    
    func addShowToFavorite(show: Show)
}

class DetailsViewModel: DetailsViewModelProtocol {

    var state: Bindable<DetailsViewControllerStates> = Bindable(value: .loading)
    let show: Show
    var casts: [Cast] = []
    var seasons: [Season] = []
    
    let service: ServiceProtocol
    let repository: RepositoryProtocol
    
    init(show: Show, service: ServiceProtocol = Service(), repository: RepositoryProtocol = Repository()) {
        self.show = show
        self.service = service
        self.repository = repository
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
    func addShowToFavorite(show: Show) {
        repository.saveShow(show) { result in
            switch result {
            case .success:
                print("DEBUG: Show added successfully!")
            case .failure(let error):
                print("DEBUG: Error \(error.localizedDescription)")
            }
        }
    }
}
