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
    func numberOfItemsInSection() -> Int
    func cellForItem(at indexPath: IndexPath) -> Cast
    func fetchCast()
}

class DetailsViewModel: DetailsViewModelProtocol {
    
    var state: Bindable<DetailsViewControllerStates> = Bindable(value: .loading)
    let show: Show
    var casts: [Cast] = []
    let service: ServiceProtocol
    
    init(show: Show, service: ServiceProtocol = Service()) {
        self.show = show
        self.service = service
    }
    
    func numberOfItemsInSection() -> Int {
        return casts.count
    }
    
    func cellForItem(at indexPath: IndexPath) -> Cast {
        return casts[indexPath.item]
    }
    
    func fetchCast() {
        state.value = .loading
        
        service.getCast(id: show.id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let cast):
                casts.append(contentsOf: cast)
                state.value = .loaded
                
            case .failure(let error):
                print("DEBUG: Error \(error.rawValue)")
                state.value = .error
            }
        }
    }
}
