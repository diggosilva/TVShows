//
//  Cast.swift
//  TVShows
//
//  Created by Diggo Silva on 24/03/25.
//

import Foundation

class Cast {
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
    
    var realGender: String {
        if gender == "Male" {
            return "Masculino"
        } else {
            return "Feminino"
        }
    }
    
    var mediumImage: String {
        return image.medium ?? ""
    }
    
    var originalImage: String {
        return image.original ?? ""
    }
    
    var countryName: String {
        return country.name ?? ""
    }
    
    var countryCode: String {
        return country.code ?? ""
    }
    
    var birth: String {
        return birthday ?? ""
    }
    
    var genero: String {
        return gender ?? ""
    }
}
