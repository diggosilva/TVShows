//
//  EpisodesViewModelTests.swift
//  TVShowsTests
//
//  Created by Diggo Silva on 31/03/25.
//

import XCTest
import Combine
@testable import TVShows

class MockEpisodes: ServiceProtocol {
    var isSuccess: Bool = true
    
    func getShows(page: Int) async throws -> [Show] { return [] }
    func getCast(id: Int) async throws -> [Cast] { return [] }
    func getSeasons(id: Int) async throws -> [Season] { return [] }
    
    func getEpisodes(id: Int) async throws -> [Episode] {
        if isSuccess {
            return [
                Episode(id: 1, name: "Pilot", season: 0, number: 0, airdate: "", airtime: "", rating: nil, image: (medium: nil, original: nil), summary: ""),
                Episode(id: 2, name: "CoPilot", season: 0, number: 0, airdate: "", airtime: "", rating: nil, image: (medium: nil, original: nil), summary: "")
            ]
        } else {
            throw DSError.episodeFailed
        }
    }
}

final class EpisodesViewModelTests: XCTestCase {
    
    let show = Show(id: 0, name: "Aviation", mediumImage: "", originalImage: "", rating: nil, summary: "")
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
        let service = MockEpisodes()
        let sut = EpisodesViewModel(show: show, season: 0, service: service)
        let expectation = XCTestExpectation(description: "State deveria ser .loaded")
        
        sut.statePublisher
            .sink { state in
                if state == .loaded {
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        
        sut.fetchEpisodes()
        
        await fulfillment(of: [expectation], timeout: 2.0)
        
        let firstEpisode = sut.cellForRow(at: IndexPath(row: 0, section: 0)).name
        let secondEpisode = sut.cellForRow(at: IndexPath(row: 1, section: 0)).name
        
        XCTAssertEqual(sut.numberOfRowsInSection(), 2)
        XCTAssertEqual(firstEpisode, "Pilot")
        XCTAssertEqual(secondEpisode, "CoPilot")
    }
    
    //MARK: TESTS FAILURE
    func testWhenGetEpisodesFailure() {
        let service = MockEpisodes()
        service.isSuccess = false
        
        let sut = EpisodesViewModel(show: show, season: 0, service: service)
        
        sut.fetchEpisodes()
        
        XCTAssertEqual(sut.numberOfRowsInSection(), 0)
    }
    
    func testWhenGetEpisodesStateError() async throws {
        let service = MockEpisodes()
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
        
        await fulfillment(of: [expectation], timeout: 2.0)
        
        XCTAssertEqual(sut.numberOfRowsInSection(), 0)
    }
}
