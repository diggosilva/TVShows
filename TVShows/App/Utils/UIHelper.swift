//
//  UIHelper.swift
//  TVShows
//
//  Created by Diggo Silva on 24/03/25.
//

import UIKit

enum DSViewBuilder {
    static func buildImageView(image: UIImage? = SFSymbols.empty?.withTintColor(.systemGray3, renderingMode: .alwaysOriginal), cornerRadius: CGFloat? = nil, borderWidth: CGFloat? = nil, contentMode: UIView.ContentMode = .scaleAspectFill) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = contentMode
        imageView.layer.cornerRadius = cornerRadius ?? 0
        imageView.layer.borderWidth = borderWidth ?? 0
        imageView.layer.borderColor = UIColor.systemGray3.cgColor
        imageView.image = image
        imageView.clipsToBounds = true
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
    
    static func buildBGView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .quaternaryLabel
        return view
    }
    
    static func buildLabelChar(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        label.text = text
        label.backgroundColor = .secondarySystemBackground
        label.layer.cornerRadius = 10
        label.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        label.clipsToBounds = true
        return label
    }
    
    static func buildLabelValueChar(text: String = "") -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.text = text
        label.numberOfLines = 2
        return label
    }
    
    static func buildSpinner(style: UIActivityIndicatorView.Style = .large) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: style)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        return spinner
    }
    
    static func buildLoadingLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        label.isHidden = true
        label.text = "Carregando..."
        return label
    }
}
