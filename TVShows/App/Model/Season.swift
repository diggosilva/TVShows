//
//  Season.swift
//  TVShows
//
//  Created by Diggo Silva on 24/03/25.
//

import Foundation

class Season {
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
    
    var mediumImage: String? {
        if let imageMedium = image.medium {
            return imageMedium
        }
        return nil
    }
    
    var originalImage: String? {
        if let imageOriginal = image.original {
            return imageOriginal
        } else {
            return nil
        }
    }
    
    var episodeCount: Int? {
        if let episodesCount = episodes {
            return episodesCount
        }
        return nil
    }
}
