//
//  Show.swift
//  TVShows
//
//  Created by Diggo Silva on 23/03/25.
//

import Foundation

class Show: CustomStringConvertible, Hashable {
    
    static func == (lhs: Show, rhs: Show) -> Bool {
        return lhs.id == rhs.id &&
        lhs.image == rhs.image &&
        lhs.name == rhs.name &&
        lhs.rating == rhs.rating
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(rating)
        hasher.combine(image)
    }
    
    let id: Int
    let name: String
    let image: String
    let rating: Double?
    
    init(id: Int, name: String,  image: String, rating: Double?) {
        self.id = id
        self.name = name
        self.image = image
        self.rating = rating
    }
    
    var description: String {
        return "Show: id: \(id),  name: \(name), image: \(image), rating: \(String(describing: rating))"
    }
}
