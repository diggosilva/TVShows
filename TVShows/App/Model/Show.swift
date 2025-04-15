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
    let mediumImage: String?
    let originalImage: String?
    let rating: Double?
    let summary: String?
    
    init(id: Int, name: String, mediumImage: String?, originalImage: String?, rating: Double?, summary: String?) {
        self.id = id
        self.name = name
        self.mediumImage = mediumImage
        self.originalImage = originalImage
        self.rating = rating
        self.summary = summary
    }
    
    var imageMedium: String {
        return mediumImage ?? ""
    }
    
    var imageOriginal: String {
        return originalImage ?? ""
    }
    
    var cleanSummary: String {
        return summary?.cleanHTML() ?? ""
    }
    
    static func == (lhs: Show, rhs: Show) -> Bool {
        return lhs.id == rhs.id &&
        lhs.mediumImage == rhs.mediumImage &&
        lhs.originalImage == rhs.originalImage &&
        lhs.name == rhs.name &&
        lhs.rating == rhs.rating &&
        lhs.summary == rhs.summary
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(rating)
        hasher.combine(mediumImage)
        hasher.combine(originalImage)
        hasher.combine(summary)
    }
}
