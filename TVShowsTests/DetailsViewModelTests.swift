//
//  DetailsViewModelTests.swift
//  TVShowsTests
//
//  Created by Diggo Silva on 31/03/25.
//

import XCTest
import Combine
@testable import TVShows

class MockDetails: ServiceProtocol {
    
    var isSuccess: Bool = true
    
    func getCast(id: Int) async throws -> [Cast] {
        if isSuccess {
            return [
                Cast(id: 1, name: "Mario", image: (medium: nil, original: nil), country: (name: nil, code: nil), birthday: nil, gender: nil),
                Cast(id: 2, name: "Luigi", image: (medium: nil, original: nil), country: (name: nil, code: nil), birthday: nil, gender: nil)
            ]
        } else {
            throw DSError.castFailed
        }
    }
    
    func getSeasons(id: Int) async throws -> [Season] {
        if isSuccess {
            return [
                Season(id: 1, number: 1, image: (medium: nil, original: nil), episodes: nil),
                Season(id: 2, number: 2, image: (medium: nil, original: nil), episodes: nil),
                Season(id: 3, number: 3, image: (medium: nil, original: nil), episodes: nil)
            ]
        } else {
            throw DSError.seasonFailed
        }
    }
    
    func getShows(page: Int) async throws -> [Show] { return [] }
    func getEpisodes(id: Int) async throws -> [Episode] { return [] }
}

class MockRepository: RepositoryProtocol {
    var isSuccess: Bool = true
    
    func getShows() -> [Show] { return [] }
    
    func saveShow(_ show: Show, completion: @escaping (Result<String, DSError>) -> Void) {
        if isSuccess {
            completion(.success(""))
        } else {
            completion(.failure(.showFailedToSave))
        }
    }
    
    func saveShows(_ shows: [Show]) {}
}


final class DetailsViewModelTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    let show = Show(id: 0, name: "Super Mario", mediumImage: "", originalImage: "", rating: nil, summary: "")
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
    }
    
    //MARK: TEST CAST SUCCESS
    func testWhenCastIsSuccess() async throws {
        let service = MockDetails()
        let sut = DetailsViewModel(show: show, service: service)
        let expectation = XCTestExpectation(description: "State deveria ser .loaded")
        
        sut.statePublisher
            .sink { state in
                if state == .loaded {
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        
        sut.fetchCast()
        
        await fulfillment(of: [expectation], timeout: 2.0)
        
        XCTAssertEqual(sut.numberOfItemsInSection(), 2)
        
        let firstActorName = sut.castForItem(at: IndexPath(row: 0, section: 0)).name
        let secondActorName = sut.castForItem(at: IndexPath(row: 1, section: 0)).name
        let getShow = sut.getShow()
        
        XCTAssertEqual(sut.numberOfItemsInSection(), 2)
        XCTAssertEqual(firstActorName, "Mario")
        XCTAssertEqual(secondActorName, "Luigi")
        XCTAssertEqual(getShow, show)
    }
    
    //MARK: TEST CAST FAILURE
    func testWhenCastFails() async throws {
        let service = MockDetails()
        service.isSuccess = false
        
        let sut = DetailsViewModel(show: show, service: service)
        let expectation = XCTestExpectation(description: "State deveria ser .error")
        
        sut.statePublisher
            .sink { state in
                if state == .error {
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        
        sut.fetchCast()
        
        await fulfillment(of: [expectation], timeout: 2.0)
        
        XCTAssertEqual(sut.numberOfItemsInSection(), 0)
    }
    
    //MARK: TEST SEASON SUCCESS
    func testWhenSeasonIsSuccess() async throws {
        let service = MockDetails()
        let sut = DetailsViewModel(show: show, service: service)
        let expectation = XCTestExpectation(description: "State deveria ser .loaded")
        
        sut.statePublisher
            .sink { state in
                if state == .loaded {
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        
        sut.fetchSeasons()
        
        await fulfillment(of: [expectation], timeout: 2.0)
        
        let firstSeasonNumber = sut.seasonForItem(at: IndexPath(row: 0, section: 0)).number
        let lastSeasonNumber = sut.seasonForItem(at: IndexPath(row: 2, section: 0)).number
        
        XCTAssertEqual(sut.numberOfSeasonsInSection(), 3)
        XCTAssertEqual(firstSeasonNumber, 1)
        XCTAssertEqual(lastSeasonNumber, 3)
    }
    
    //MARK: TEST SEASON FAILURE
    func testWhenSeasonFails() async throws {
        let service = MockDetails()
        service.isSuccess = false
        
        let sut = DetailsViewModel(show: show, service: service)
        let expectation = XCTestExpectation(description: "State deveria ser .error")
        
        sut.statePublisher
            .sink { state in
                if state == .error {
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        
        sut.fetchSeasons()
        
        await fulfillment(of: [expectation], timeout: 2.0)
        
        XCTAssertEqual(sut.numberOfSeasonsInSection(), 0)
    }
    
    //MARK: TEST ADD SHOW TO FAVORITES SUCCESS
    func testWhenAddShowToFavoritesSuccess() {
        let repository = MockRepository()
        let sut = DetailsViewModel(show: show, service: MockDetails(), repository: repository)
        
        var alertTitle: String?
        var alertMessage: String?
        sut.addShowToFavorite(show: show) { result in
            switch result {
            case .success:
                XCTAssertEqual(alertTitle, "Sucesso! 🎉")
                XCTAssertEqual(alertMessage, "Série adicionada aos favoritos!")
            case .failure:
                XCTFail("A série deve ter sido adicionada com sucesso!")
            }
        }
    }
    
    //MARK: TEST ADD SHOW TO FAVORITES FAILURE
    func testWhenAddShowToFavoritesFailure() {
        let repository = MockRepository()
        repository.isSuccess = false
        
        let sut = DetailsViewModel(show: show, service: MockDetails(), repository: repository)
        
        var alertTitle: String?
        var alertMessage: String?
        sut.addShowToFavorite(show: show) { result in
            switch result {
            case .success:
                XCTFail("A série não deveria ter sido adicionada com sucesso!")
            case .failure:
                XCTAssertEqual(alertTitle, "Erro! 😱")
                XCTAssertEqual(alertMessage, "Não foi possível adicionar a série aos favoritos.")
            }
        }
    }
}
