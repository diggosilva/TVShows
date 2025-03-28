//
//  Episode.swift
//  TVShows
//
//  Created by Diggo Silva on 27/03/25.
//

import Foundation

class Episode: CustomStringConvertible {
    let id: Int
    let name: String
    let number: Int
    let airdate: String
    let airtime: String
    let rating: Double?
    let image: (medium: String?, original: String?)
    let summary: String
    
    init(id: Int, name: String, number: Int, airdate: String, airtime: String, rating: Double?, image: (medium: String?, original: String?), summary: String) {
        self.id = id
        self.name = name
        self.number = number
        self.airdate = airdate
        self.airtime = airtime
        self.rating = rating
        self.image = image
        self.summary = summary
    }
    
    var summaryShort: String {
        let initialSummary = "<p>"
        let finalSummary = "</p>"
        if summary.hasPrefix(initialSummary) && summary.hasSuffix(finalSummary) {
            return String(summary.dropFirst(3).dropLast(4))
        } else {
            return summary
        }
    }
    
    var description: String {
        if let mediumImage = image.medium,
           let originalImage = image.original,
           let rate = rating {
            return "Episode: id: \(id), name: \(name), number: \(number), airdate: \(airdate), airtime: \(airtime), rating: \(rate), image: \(mediumImage), imageLarge: \(originalImage), summary: \(summaryShort)"
        }
        return "Episode: id: \(id), name: \(name), number: \(number), airdate: \(airdate), airtime: \(airtime), rating: \(String(describing: rating)), image: \(String(describing: image.medium)), imageLarge: \(String(describing: image.original)), summary: \(summaryShort)"
    }
}
