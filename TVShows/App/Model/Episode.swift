//
//  Episode.swift
//  TVShows
//
//  Created by Diggo Silva on 27/03/25.
//

import Foundation
import UIKit

class Episode {
    let id: Int
    let name: String
    let season: Int
    let number: Int
    let airdate: String
    let airtime: String
    let rating: Double?
    let image: (medium: String?, original: String?)
    let summary: String?
    
    init(id: Int, name: String, season: Int, number: Int, airdate: String, airtime: String, rating: Double?, image: (medium: String?, original: String?), summary: String?) {
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
    
    var rate: Double {
        return rating ?? 0.0
    }
    
    var mediumImage: String {
        return image.medium ?? ""
    }
    
    var originalImage: String {
        return image.original ?? ""
    }
    
    var cleanSummary: String {
        return summary?.cleanHTML() ?? ""
    }
    
    func updateRatingImage(image: UIImageView) {
        if rating ?? 0.0 < 3.3 {
            image.image = SFSymbols.star?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        } else if rating ?? 0.0 >= 3.3 && rating ?? 0.0 < 6.6 {
            image.image = SFSymbols.starHalf?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        } else {
            image.image = SFSymbols.starFill?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        }
    }
}
