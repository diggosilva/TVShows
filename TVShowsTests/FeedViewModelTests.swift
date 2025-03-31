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
    
    func getShows(page: Int, completion: @escaping (Result<[Show], DSError>) -> Void) {}
    
    func getCast(id: Int, completion: @escaping (Result<[Cast], DSError>) -> Void) {}
    
    func getSeasons(id: Int, completion: @escaping (Result<[Season], DSError>) -> Void) {}
    
    func getEpisodes(id: Int, completion: @escaping (Result<[Episode], DSError>) -> Void) {}
}

final class TVShowsTests: XCTestCase {
    
    
}
