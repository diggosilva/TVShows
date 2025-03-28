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
    var gender: String?
    
    init(id: Int, name: String, image: (medium: String?, original: String?), country: (name: String?, code: String?), birthday: String?, gender: String?) {
        self.id = id
        self.name = name
        self.image = image
        self.country = country
        self.birthday = birthday
        self.gender = gender
    }
    
    var realGender: String? {
        if gender == "Male" {
            return "Masculino"
        } else if gender == "Female" {
            return "Feminino"
        }
        return nil
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
    
    var countryName: String? {
        if let countryName = country.name {
            return countryName
        }
        return nil
    }
    
    var countryCode: String? {
        if let countryCode = country.code {
            return countryCode
        }
        return nil
    }
    
    var description: String {
        return "Cast: id: \(id), name: \(name), image: \(mediumImage ?? ""), imageLarge: \(originalImage ?? ""), countryName: \(countryName ?? ""), countryCode: \(countryCode ?? ""), birthday: \(birthday ?? ""), gender: \(realGender ?? "")"
    }
}
