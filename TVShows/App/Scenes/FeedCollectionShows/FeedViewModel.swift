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
}

protocol FeedViewModelProtocol {
    var state: Bindable<FeedViewControllerStates> { get }
    var showsFiltered: Bindable<[Show]> { get }
    var shows: [Show] { get }
    var isSearching: Bool { get set }
//    var hasMoreFollowers: Bool { get }
//    var isLoadingMoreFollowers: Bool { get }
    var page: Int { get set }
    func numberOfItemsInSection() -> Int
    func cellForItem(at indexPath: IndexPath) -> Show
    func searchBar(textDidChange searchText: String)
    func fetchShows()
}

//class FeedViewModel: FeedViewModelProtocol {
//    
//    private(set) var state: Bindable<FeedViewControllerStates> = Bindable(value: .loading)
//    private var page: Int = 1
//    private var shows: [Show] = []
//    private var showsFiltered: [Show] = []
//    
//    let service: ServiceProtocol
//    
//    init(service: ServiceProtocol = Service()) {
//        self.service = service
//    }
//    
//    func numberOfItemsInSection() -> Int {
//        return showsFiltered.count
//    }
//    
//    func cellForItem(at indexPath: IndexPath) -> Show {
//        return showsFiltered[indexPath.item]
//    }
//    
//    func searchBar(textDidChange searchText: String) {
//        showsFiltered = []
//        
//        if searchText.isEmpty {
//            showsFiltered = shows
//        } else {
//            for show in shows {
//                if show.name.lowercased().contains(searchText.lowercased()) {
//                    showsFiltered.append(show)
//                }
//            }
//        }
//    }
//    
//    func fetchShows() {
//        state.value = .loading
//        
//        service.getShows { [weak self] result in
//            guard let self = self else { return }
//           
//            switch result {
//            case .success(let shows):
//                self.shows.append(contentsOf: shows)
//                showsFiltered.append(contentsOf: shows)
//                state.value = .loaded
//                
//            case .failure(let error):
//                print("Error: \(error.rawValue)")
//                state.value = .error
//            }
//        }
//    }
//}

class FeedViewModel: FeedViewModelProtocol {
    
    private(set) var state: Bindable<FeedViewControllerStates> = Bindable(value: .loading)
    private(set) var showsFiltered: Bindable<[Show]> = Bindable(value: [])
    private(set) var shows: [Show] = []
    var isSearching: Bool = false
    
    var page: Int = 0
    
    let service: ServiceProtocol
    
    init(service: ServiceProtocol = Service()) {
        self.service = service
    }
    
    func numberOfItemsInSection() -> Int {
        return showsFiltered.value.count
    }
    
    func cellForItem(at indexPath: IndexPath) -> Show {
        return showsFiltered.value[indexPath.item]
    }
    
    func searchBar(textDidChange searchText: String) {
        if searchText.isEmpty {
            showsFiltered.value = shows
        } else {
            showsFiltered.value = shows.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    func fetchShows() {
        state.value = .loading
        
        service.getShows(page: page) { [weak self] result in
            guard let self = self else { return }
           
            switch result {
            case .success(let shows):
                self.shows.append(contentsOf: shows)
                self.showsFiltered.value.append(contentsOf: shows)
                self.state.value = .loaded
                
            case .failure(let error):
                print("Error: \(error.rawValue)")
                self.state.value = .error
            }
        }
    }
}
