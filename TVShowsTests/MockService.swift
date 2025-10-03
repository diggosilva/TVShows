//
//  MockService.swift
//  TVShowsTests
//
//  Created by Diggo Silva on 03/10/25.
//

import XCTest
import Combine
@testable import TVShows

class MockService: ServiceProtocol {
    
    var isSuccess: Bool = true
    var shouldReturnEmpty = false
    
    func getShows(page: Int) async throws -> [Show] {
        if isSuccess {
            if shouldReturnEmpty {
                return []
            } else {
                return [
                    Show(id: 1, name: "Teste", mediumImage: "", originalImage: "", rating: 0.0, summary: ""),
                    Show(id: 2, name: "Show", mediumImage: "", originalImage: "", rating: 0.0, summary: "")
                ]
            }
        } else {
            throw DSError.showsFailed
        }
    }
    
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
