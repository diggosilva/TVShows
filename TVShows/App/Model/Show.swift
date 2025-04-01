//
//  Show.swift
//  TVShows
//
//  Created by Diggo Silva on 23/03/25.
//

import Foundation

class Show: Codable, Hashable {
    let id: Int
    let name: String
    let image: String
    let imageLarge: String
    let rating: Double?
    let summary: String
    
    init(id: Int, name: String,  image: String, imageLarge: String, rating: Double?, summary: String) {
        self.id = id
        self.name = name
        self.image = image
        self.imageLarge = imageLarge
        self.rating = rating
        self.summary = summary
    }
    
    var cleanSummary: String {
        return summary.cleanHTML()
    }
    
    static func == (lhs: Show, rhs: Show) -> Bool {
        return lhs.id == rhs.id &&
        lhs.image == rhs.image &&
        lhs.imageLarge == rhs.imageLarge &&
        lhs.name == rhs.name &&
        lhs.rating == rhs.rating &&
        lhs.summary == rhs.summary
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(rating)
        hasher.combine(image)
        hasher.combine(imageLarge)
        hasher.combine(summary)
    }
}
