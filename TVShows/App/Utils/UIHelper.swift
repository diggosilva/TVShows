//
//  UIHelper.swift
//  TVShows
//
//  Created by Diggo Silva on 24/03/25.
//

import UIKit

enum DSViewBuilder {
    static func buildImageView(cornerRadius: CGFloat? = nil, borderWidth: CGFloat? = nil) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = cornerRadius ?? 0
        imageView.layer.borderWidth = borderWidth ?? 0
        imageView.layer.borderColor = UIColor.systemGray3.cgColor
        return imageView
    }
    
    static func buildLabel(text: String = "", textColor: UIColor = .label, textAlignment: NSTextAlignment = .left, font: UIFont = .preferredFont(forTextStyle: .extraLargeTitle), numberOfLines: Int = 1) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.font = font
        label.numberOfLines = numberOfLines
        return label
    }
}
