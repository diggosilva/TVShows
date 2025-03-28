//
//  Season.swift
//  TVShows
//
//  Created by Diggo Silva on 24/03/25.
//

import Foundation

class Season: CustomStringConvertible {
    let id: Int
    let number: Int
    let image: (medium: String?, original: String?)
    let episodes: Int?
    
    init(id: Int, number: Int, image: (medium: String?, original: String?), episodes: Int?) {
        self.id = id
        self.number = number
        self.image = image
        self.episodes = episodes
    }
    
    var description: String {
        if let imageMedium = image.medium,
           let imageOriginal = image.original,
           let episodes = episodes {
            return "Season: id: \(id), number:\(number), imageMedium:\(imageMedium), imageOriginal:\(imageOriginal), episodes:\(episodes)"
        }
        
        return "Season: id: \(id), number:\(number), image:\(String(describing: image.medium)), imageLarge:\(String(describing: image.original)), episodes:\(String(describing: episodes)))"
    }
}
