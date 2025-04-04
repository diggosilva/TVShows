//
//  FavoritesViewModelTests.swift
//  TVShowsTests
//
//  Created by Diggo Silva on 01/04/25.
//

import XCTest
@testable import TVShows

class MockFavorites: RepositoryProtocol {
    var isSuccess: Bool = true
    var shows: [Show] = []
    
    func getShows() -> [Show] {
        return shows
    }
    
    func saveShow(_ show: Show, completion: @escaping (Result<String, DSError>) -> Void) {
        if isSuccess {
            shows.append(show)
            completion(.success(show.name))
        } else {
            completion(.failure(.showAlreadySaved))
        }
    }
    
    func saveShows(_ shows: [Show]) {
        self.shows = shows
    }
}

class MockDelegate: FavoritesViewModelDelegate {
    var reloadTableCalled = false
    
    func reloadTable() {
        reloadTableCalled = true
    }
}

final class FavoritesViewModelTests: XCTestCase {
    
    //MARK: TEST FAVORITES SUCCESS
    func testWhenSuccess() {
        let repository = MockFavorites()
        let sut = FavoritesViewModel(repository: repository)
        
        let show = Show(id: 1, name: "Breaking Bad", mediumImage: "", originalImage: "", rating: nil, summary: "")
        
        repository.saveShow(show) { result in
            switch result {
            case .success(let showName):
                XCTAssertEqual(showName, "Breaking Bad")
                XCTAssertTrue(repository.shows.contains(where: { $0.id == show.id }))
                
            case .failure:
                XCTFail("Esperava um sucesso, mas ocorreu um erro")
            }
        }
        
        sut.loadShows()
        
        let nameShow = sut.cellForRow(at: IndexPath(row: 0, section: 0)).name
        
        XCTAssertEqual(sut.numberOfRowsInSection(), 1)
        XCTAssertEqual(nameShow, "Breaking Bad")
    }
    
    func testSaveShows() {
        let repository = MockFavorites()
        let sut = FavoritesViewModel(repository: repository)
        
        let shows = [Show(id: 1, name: "Breaking Bad", mediumImage: "", originalImage: "", rating: nil, summary: ""),
                     Show(id: 2, name: "Prison Break", mediumImage: "", originalImage: "", rating: nil, summary: "")]
        
        sut.saveShows()
        XCTAssertEqual(shows.count, 2)
    }
    
    //MARK: TEST FAVORITES FAILURE
    func testWhenFailure() {
        let repository = MockFavorites()
        repository.isSuccess = false
        
        let sut = FavoritesViewModel(repository: repository)
        
        let show = Show(id: 1, name: "Breaking Bad", mediumImage: "", originalImage: "", rating: nil, summary: "")
        
        XCTAssertEqual(sut.numberOfRowsInSection(), 0)
        
        repository.saveShow(show) { result in
            switch result {
            case .success:
                XCTFail("Esperava um erro, mas ocorreu um sucesso")
                
            case .failure(let error):
                XCTAssertEqual(error, DSError.showAlreadySaved)
            }
        }
    }
    
    //MARK: TEST REMOVE SHOW
    func testRemoveShow() {
        let repository = MockFavorites()
        let sut = FavoritesViewModel(repository: repository)
        let mockDelegate = MockDelegate()
        
        let shows = [Show(id: 1, name: "Breaking Bad", mediumImage: "", originalImage: "", rating: nil, summary: ""),
                     Show(id: 2, name: "Prison Break", mediumImage: "", originalImage: "", rating: nil, summary: "")]
        
        repository.saveShows(shows)
        
        sut.loadShows()
        XCTAssertEqual(sut.numberOfRowsInSection(), 2)
        
        sut.setDelegate(mockDelegate)
        
        sut.removeShow(at: 0)
        XCTAssertEqual(sut.numberOfRowsInSection(), 1)
        
        let remainingShowName = sut.cellForRow(at: IndexPath(row: 0, section: 0)).name
        XCTAssertEqual(remainingShowName, "Prison Break")
    }
}
