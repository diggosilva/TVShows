//
//  Episode.swift
//  TVShows
//
//  Created by Diggo Silva on 27/03/25.
//

import Foundation

class Episode {
    let id: Int
    let name: String
    let season: Int
    let number: Int
    let airdate: String
    let airtime: String
    let rating: Double?
    let image: (medium: String?, original: String?)
    let summary: String
    
    init(id: Int, name: String, season: Int, number: Int, airdate: String, airtime: String, rating: Double?, image: (medium: String?, original: String?), summary: String) {
        self.id = id
        self.name = name
        self.season = season
        self.number = number
        self.airdate = airdate
        self.airtime = airtime
        self.rating = rating
        self.image = image
        self.summary = summary
    }
    
    var rate: Double? {
        if let rate = rating {
            return rate
        } else {
            return nil
        }
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
    
    var cleanSummary: String {
        return summary.cleanHTML()
    }
}
