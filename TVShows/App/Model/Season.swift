//
//  Season.swift
//  TVShows
//
//  Created by Diggo Silva on 24/03/25.
//

import Foundation

class Season: CustomStringConvertible {
    let id: Int
    let number: String
    let image: String
    let episodes: Int
    
    init(id: Int, number: String, image: String, episodes: Int) {
        self.id = id
        self.number = number
        self.image = image
        self.episodes = episodes
    }
    
    var description: String {
        return "Season: id: \(id), number:\(number), image:\(image), episodes:\(episodes)"
    }
}

