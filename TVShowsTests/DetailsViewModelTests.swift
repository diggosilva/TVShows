//
//  DetailsViewModelTests.swift
//  TVShowsTests
//
//  Created by Diggo Silva on 31/03/25.
//

import XCTest
@testable import TVShows

class MockDetails: ServiceProtocol {
    var isSuccess: Bool = true
    
    func getShows(page: Int, completion: @escaping (Result<[Show], DSError>) -> Void) {}
    
    func getCast(id: Int, completion: @escaping (Result<[Cast], DSError>) -> Void) {
        if isSuccess {
            completion(.success([
                Cast(id: 1, name: "Mario", image: (medium: nil, original: nil), country: (name: nil, code: nil), birthday: nil, gender: nil),
                Cast(id: 2, name: "Luigi", image: (medium: nil, original: nil), country: (name: nil, code: nil), birthday: nil, gender: nil)
            ]))
        } else {
            completion(.failure(.castFailed))
        }
    }
    
    func getSeasons(id: Int, completion: @escaping (Result<[Season], DSError>) -> Void) {
        if isSuccess {
            completion(.success([
                Season(id: 1, number: 1, image: (medium: nil, original: nil), episodes: nil),
                Season(id: 2, number: 2, image: (medium: nil, original: nil), episodes: nil),
                Season(id: 3, number: 3, image: (medium: nil, original: nil), episodes: nil)
            ]))
        } else {
            completion(.failure(.seasonFailed))
        }
    }
    
    func getEpisodes(id: Int, completion: @escaping (Result<[Episode], DSError>) -> Void) {}
}

final class DetailsViewModelTests: XCTestCase {
    let show = Show(id: 0, name: "Super Mario", image: "", imageLarge: "", rating: nil, summary: "")
    
    //MARK: TEST CAST SUCCESS
    func testWhenCastIsSuccess() {
        let service = MockDetails()
        let sut = DetailsViewModel(show: show, service: service)
        
        XCTAssertEqual(sut.numberOfItemsInSection(), 0)
        
        sut.fetchCast()
        
        let firstActorName = sut.castForItem(at: IndexPath(row: 0, section: 0)).name
        let secondActorName = sut.castForItem(at: IndexPath(row: 1, section: 0)).name
        
        XCTAssertEqual(sut.numberOfItemsInSection(), 2)
        XCTAssertEqual(firstActorName, "Mario")
        XCTAssertEqual(secondActorName, "Luigi")
    }
    
    //MARK: TEST CAST FAILURE
    func testWhenCastFails() {
        let service = MockDetails()
        service.isSuccess = false
        
        let sut = DetailsViewModel(show: show, service: service)
        
        XCTAssertEqual(sut.numberOfItemsInSection(), 0)
        
        sut.fetchCast()
        
        XCTAssertEqual(sut.numberOfItemsInSection(), 0)
        XCTAssertEqual(sut.state.value, .error)
    }
    
    //MARK: TEST SEASON SUCCESS
    func testWhenSeasonIsSuccess() {
        let service = MockDetails()
        let sut = DetailsViewModel(show: show, service: service)
        
        XCTAssertEqual(sut.numberOfSeasonsInSection(), 0)
        
        sut.fetchSeasons()
        
        let firstSeasonNumber = sut.seasonForItem(at: IndexPath(row: 0, section: 0)).number
        let lastSeasonNumber = sut.seasonForItem(at: IndexPath(row: 2, section: 0)).number
        
        XCTAssertEqual(sut.numberOfSeasonsInSection(), 3)
        XCTAssertEqual(firstSeasonNumber, 1)
        XCTAssertEqual(lastSeasonNumber, 3)
    }
    
    //MARK: TEST SEASON FAILURE
    func testWhenSeasonFails() {
        let service = MockDetails()
        service.isSuccess = false
        
        let sut = DetailsViewModel(show: show, service: service)
        
        XCTAssertEqual(sut.numberOfSeasonsInSection(), 0)
        
        sut.fetchSeasons()
        
        XCTAssertEqual(sut.numberOfSeasonsInSection(), 0)
        XCTAssertEqual(sut.state.value, .error)
    }
    
    //MARK: TEST ADD SHOW TO FAVORITES SUCCESS
    func testWhenAddShowToFavoritesSuccess() {
        let repository = MockRepository()
        let sut = DetailsViewModel(show: show, service: MockDetails(), repository: repository)
        
        var alertTitle: String?
        var alertMessage: String?
        sut.showAlert = { title, message in
            alertTitle = title
            alertMessage = message
        }
        
        sut.addShowToFavorite(show: show) { result in
            switch result {
            case .success:
                XCTAssertNotNil(alertTitle, "Alert title should not be nil")
                XCTAssertNotNil(alertMessage, "Alert message should not be nil")
                XCTAssertEqual(alertTitle, "Sucesso! 🎉")
                XCTAssertEqual(alertMessage, "Série adicionada aos favoritos!")
            case .failure:
                XCTFail("Show should have been added successfully")
            }
        }
    }
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
