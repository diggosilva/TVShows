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
    let image: (medium: String?, original: String?)
    let country: (name: String?, code: String?)
    let birthday: String?
    let gender: String?
    
    
    init(id: Int, name: String, image: (medium: String?, original: String?), country: (name: String?, code: String?), birthday: String?, gender: String?) {
        self.id = id
        self.name = name
        self.image = image
        self.country = country
        self.birthday = birthday
        self.gender = gender
    }
    
    var description: String {
        if let gender = gender,
           let imageMedium = image.medium,
           let imageOriginal = image.original,
           let countryName = country.name,
           let countryCode = country.code {
            return "Cast: id: \(id), name: \(name), image: \(imageMedium), imageLarge: \(imageOriginal), countryName: \(countryName)), countryCode: \(String(describing: countryCode)), birthday: \(birthday ?? ""), gender: \(String(describing: gender))"
        }
        return "Cast: id: \(id), name: \(name), image: \(String(describing: image.medium)), imageLarge: \(String(describing: image.original)), countryName: \(String(describing: country.name)), countryCode: \(String(describing: country.code)), birthday: \(birthday ?? ""), gender: \(String(describing: gender))"
    }
}
