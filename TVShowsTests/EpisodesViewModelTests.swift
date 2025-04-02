//
//  EpisodesViewModelTests.swift
//  TVShowsTests
//
//  Created by Diggo Silva on 31/03/25.
//

import XCTest
@testable import TVShows

class MockEpisodes: ServiceProtocol {
    var isSuccess: Bool = true
    
    func getShows(page: Int, completion: @escaping (Result<[Show], DSError>) -> Void) {}
    
    func getCast(id: Int, completion: @escaping (Result<[Cast], DSError>) -> Void) {}
    
    func getSeasons(id: Int, completion: @escaping (Result<[Season], DSError>) -> Void) {}
    
    func getEpisodes(id: Int, completion: @escaping (Result<[Episode], DSError>) -> Void) {
        if isSuccess {
            completion(.success([
                Episode(id: 1, name: "Pilot", season: 0, number: 0, airdate: "", airtime: "", rating: nil, image: (medium: nil, original: nil), summary: ""),
                Episode(id: 2, name: "CoPilot", season: 0, number: 0, airdate: "", airtime: "", rating: nil, image: (medium: nil, original: nil), summary: "")
            ]))
        } else {
            completion(.failure(.episodeFailed))
        }
    }
}

final class EpisodesViewModelTests: XCTestCase {
    let show = Show(id: 0, name: "Aviation", image: "", imageLarge: "", rating: nil, summary: "")
    
    //MARK: TESTS SUCCESS
    func testWhenGetEpisodesSuccess() {
        let service = MockEpisodes()
        let sut = EpisodesViewModel(show: show, season: 0, service: service)
        
        XCTAssertEqual(sut.numberOfRowsInSection(), 0)
        
        sut.fetchEpisodes()
        
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
        XCTAssertEqual(sut.state.value, .error)
    }
}
