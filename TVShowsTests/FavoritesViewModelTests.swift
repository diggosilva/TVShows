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

final class FavoritesViewModelTests: XCTestCase {
    
    //MARK: TEST FAVORITES SUCCESS
    func testWhenSuccess() {
        let repository = MockFavorites()
        let sut = FavoritesViewModel(repository: repository)
        
        let show = Show(id: 1, name: "Breaking Bad", image: "", imageLarge: "", rating: nil, summary: "")
        
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
        
        let show1 = Show(id: 1, name: "Breaking Bad", image: "", imageLarge: "", rating: nil, summary: "")
        let show2 = Show(id: 2, name: "Prison Break", image: "", imageLarge: "", rating: nil, summary: "")
        
        sut.shows = [show1, show2]
        sut.saveShows()
        
        XCTAssertEqual(sut.shows.count, 2)
        XCTAssertTrue(sut.shows.contains(where: { $0.id == show1.id }))
        XCTAssertTrue(sut.shows.contains(where: { $0.id == show2.id }))
    }
    
    //MARK: TEST FAVORITES FAILURE
    func testWhenFailure() {
        let repository = MockFavorites()
        repository.isSuccess = false
        
        let sut = FavoritesViewModel(repository: repository)
        
        let show = Show(id: 1, name: "Breaking Bad", image: "", imageLarge: "", rating: nil, summary: "")
        
        XCTAssertEqual(sut.numberOfRowsInSection(), 0)
        XCTAssertTrue(sut.shows.isEmpty)
        
        repository.saveShow(show) { result in
            switch result {
            case .success:
                XCTFail("Esperava um erro, mas ocorreu um sucesso")
                
            case .failure(let error):
                XCTAssertEqual(error, DSError.showAlreadySaved)
            }
        }
    }
}
