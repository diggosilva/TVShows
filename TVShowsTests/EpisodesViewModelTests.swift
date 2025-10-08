//
//  EpisodesViewModelTests.swift
//  TVShowsTests
//
//  Created by Diggo Silva on 31/03/25.
//

import XCTest
import Combine
@testable import TVShows

final class EpisodesViewModelTests: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
    }
    
    //MARK: TESTS SUCCESS
    func testWhenGetEpisodesSuccess() async throws {
        let show = Show(id: 0, name: "Aviation", mediumImage: "", originalImage: "", rating: nil, summary: "")
        let service = MockService()
        let sut = EpisodesViewModel(show: show, season: 0, service: service)
        let expectation = XCTestExpectation(description: "State deveria ser .loaded")
        
        sut.statePublisher
            .sink { state in
                if state == .loaded {
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        
        sut.fetchEpisodes()
        
        await fulfillment(of: [expectation], timeout: 1.0)
        
        let firstEpisode = sut.cellForRow(at: IndexPath(row: 0, section: 0)).name
        let secondEpisode = sut.cellForRow(at: IndexPath(row: 1, section: 0)).name
        
        XCTAssertEqual(sut.numberOfRowsInSection(), 2)
        XCTAssertEqual(firstEpisode, "Pilot")
        XCTAssertEqual(secondEpisode, "CoPilot")
    }
    
    //MARK: TESTS FAILURE
    func testWhenGetEpisodesFailure() {
        let show = Show(id: 0, name: "Aviation", mediumImage: "", originalImage: "", rating: nil, summary: "")
        let service = MockService()
        service.isSuccess = false
        
        let sut = EpisodesViewModel(show: show, season: 0, service: service)
        
        sut.fetchEpisodes()
        
        XCTAssertEqual(sut.numberOfRowsInSection(), 0)
    }
    
    func testWhenGetEpisodesStateError() async throws {
        let show = Show(id: 0, name: "Aviation", mediumImage: "", originalImage: "", rating: nil, summary: "")
        let service = MockService()
        service.isSuccess = false
        
        let sut = EpisodesViewModel(show: show, season: 0, service: service)
        let expectation = XCTestExpectation(description: "State deveria ser .error")
        
        sut.statePublisher
            .sink { state in
                if state == .error {
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        
        sut.fetchEpisodes()
        
        await fulfillment(of: [expectation], timeout: 1.0)
        
        XCTAssertEqual(sut.numberOfRowsInSection(), 0)
    }
}
