//
//  TVMazeEndpoint.swift
//  TVShows
//
//  Created by Diggo Silva on 28/03/25.
//

import Foundation

enum TVMazeEndpoint {
    case shows
    case pagedShows(page: Int)
    case showByID(id: Int)
    case castForShow(id: Int)
    case seasonsForShow(id: Int)
    case episodesForShow(id: Int)
    
    var path: String {
        switch self {
        case .shows:
            return "/shows"
       
        case .pagedShows:
            return "/shows"
       
        case .showByID(let id):
            return "/shows/\(id)"
       
        case .castForShow(let id):
            return "/shows/\(id)/cast"
            
        case .seasonsForShow(let id):
            return "/shows/\(id)/seasons"
            
        case .episodesForShow(let id):
            return "/shows/\(id)/episodes"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .shows:
            return nil
            
        case .pagedShows(let page):
            return [URLQueryItem(name: "page", value: "\(page)")]
            
        case .showByID:
            return nil
            
        case .castForShow:
            return nil
            
        case .seasonsForShow:
            return nil
            
        case .episodesForShow:
            return nil
        }
    }
}
