//
//  TVShowsTests.swift
//  TVShowsTests
//
//  Created by Diggo Silva on 30/03/25.
//

import XCTest
@testable import TVShows

class MockFeed: ServiceProtocol {
    var isSuccess: Bool = true
    
    func getShows(page: Int, completion: @escaping (Result<[Show], DSError>) -> Void) {
        if isSuccess {
            completion(.success([
                Show(id: 1, name: "Teste", image: "", imageLarge: "", rating: 0.0),
                Show(id: 2, name: "Show", image: "", imageLarge: "", rating: 0.0)]))
        } else {
            completion(.failure(.showsFailed))
        }
    }
    
    func getCast(id: Int, completion: @escaping (Result<[Cast], DSError>) -> Void) {}
    
    func getSeasons(id: Int, completion: @escaping (Result<[Season], DSError>) -> Void) {}
    
    func getEpisodes(id: Int, completion: @escaping (Result<[Episode], DSError>) -> Void) {}
}

final class TVShowsTests: XCTestCase {
    
    //MARK: TESTS SUCCESS
    func testWhenGettingShowsSuccessfully() {
        let mockService = MockFeed()
        let sut = FeedViewModel(service: mockService)
        
        XCTAssertEqual(sut.shows.count, 0)
        
        sut.fetchShows()
        XCTAssertEqual(sut.numberOfItemsInSection(), 2)
        XCTAssertEqual(sut.cellForItem(at: IndexPath(row: 1, section: 0)).name, "Show")
        XCTAssertEqual(sut.shows.count, 2)
        
        sut.searchBar(textDidChange: "tes")
        
        XCTAssertEqual(sut.numberOfItemsInSection(), 1)
        
        sut.searchBar(textDidChange: "")
        XCTAssertEqual(sut.showsFiltered.value, sut.shows)
    }
    
    //MARK: TESTS FAILURE
    func testWhenGettingShowsFailed() {
        let mockService = MockFeed()
        mockService.isSuccess = false
        let sut = FeedViewModel(service: mockService)
        
        sut.fetchShows()
        XCTAssertEqual(sut.numberOfItemsInSection(), 0)
        XCTAssertEqual(sut.shows.count, 0)
        XCTAssertEqual(sut.showsFiltered.value, [])
        XCTAssertEqual(sut.state.value, .error)
    }
}
