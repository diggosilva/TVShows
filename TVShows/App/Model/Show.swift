//
//  Show.swift
//  TVShows
//
//  Created by Diggo Silva on 23/03/25.
//

import Foundation

class Show: CustomStringConvertible, Hashable {
    let id: Int
    let name: String
    let image: String
    let imageLarge: String
    let rating: Double?
    
    init(id: Int, name: String,  image: String, imageLarge: String, rating: Double?) {
        self.id = id
        self.name = name
        self.image = image
        self.imageLarge = imageLarge
        self.rating = rating
    }
    
    var description: String {
        return "Show: id: \(id),  name: \(name), image: \(image), imageLarge: \(imageLarge), rating: \(String(describing: rating))"
    }
    
    static func == (lhs: Show, rhs: Show) -> Bool {
        return lhs.id == rhs.id &&
        lhs.image == rhs.image &&
        lhs.imageLarge == rhs.imageLarge &&
        lhs.name == rhs.name &&
        lhs.rating == rhs.rating
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(rating)
        hasher.combine(image)
        hasher.combine(imageLarge)
    }
}
