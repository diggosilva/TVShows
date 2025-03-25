//
//  Cast.swift
//  TVShows
//
//  Created by Diggo Silva on 24/03/25.
//

import Foundation

class Cast: CustomStringConvertible {
    let id: Int
    let name: String
    let image: String
    
    init(id: Int, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
    
    var description: String {
        return "Cast: id: \(id), name: \(name), image: \(image)"
    }
}
