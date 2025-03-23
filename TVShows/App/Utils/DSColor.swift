//
//  DSColor.swift
//  TVShows
//
//  Created by Diggo Silva on 21/03/25.
//

import UIKit

final class DSColor {
    static let verdeEscuro = color(r: 21, g: 64, b: 56, a: 1)
    static let verdeMedio  = color(r: 29, g: 115, b: 99, a: 1)
    static let verdeClaro  = color(r: 61, g: 148, b: 139, a: 1)
    static let branco      = color(r: 242, g: 242, b: 242, a: 1)
    static let preto       = color(r: 13,  g: 13,  b: 13,  a: 1)
}

func color(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
    return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
}
