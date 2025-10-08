//
//  TVShowsTests.swift
//  TVShowsTests
//
//  Created by Diggo Silva on 30/03/25.
//

import XCTest
import Combine
@testable import TVShows

final class TVShowsTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
    }
    
    //MARK: TESTS SUCCESS
    func testWhenGettingShowsSuccessfully() async throws {
        let mockService = MockService()
        let sut = FeedViewModel(service: mockService)
        let expectation = XCTestExpectation(description: "State deveria ser .loaded")
        
        sut.statePublisher
            .receive(on: RunLoop.main)
            .sink { state in
                if state == .loaded {
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
                
        sut.fetchShows()
        
        await fulfillment(of: [expectation], timeout: 0.01)
        
        XCTAssertEqual(sut.numberOfItemsInSection(), 2)
        XCTAssertEqual(sut.cellForItem(at: IndexPath(row: 1, section: 0)).name, "Show")
        
        sut.searchBar(textDidChange: "tes")
        
        XCTAssertEqual(sut.numberOfItemsInSection(), 1)
        
        sut.searchBar(textDidChange: "")
    }
    
    //MARK: TESTS FAILURE
    func testWhenGettingShowsFailed() {
        let mockService = MockService()
        mockService.isSuccess = false
        let sut = FeedViewModel(service: mockService)
        
        sut.fetchShows()
        XCTAssertEqual(sut.numberOfItemsInSection(), 0)
    }
    
    func testFetchShowsWhenServiceReturnsEmptyShouldSetHasMorePagesFalse() async throws {
        let mockService = MockService()
        mockService.shouldReturnEmpty = true
        
        let sut = FeedViewModel(service: mockService)
        let expectation = XCTestExpectation(description: "State deveria ser .loaded")
        
        sut.statePublisher
            .dropFirst()
            .sink { state in
                if state == .loaded || state == .loading || state == .error {
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        
        sut.fetchShows()
        
        await fulfillment(of: [expectation], timeout: 0.01)
        
        XCTAssertEqual(sut.numberOfItemsInSection(), 0)
    }
}
