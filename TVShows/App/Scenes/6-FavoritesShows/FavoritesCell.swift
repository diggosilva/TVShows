//
//  FavoritesCell.swift
//  TVShows
//
//  Created by Diggo Silva on 01/04/25.
//

import UIKit
import SDWebImage

class FavoritesCell: UITableViewCell {
    
    static let identifier = "FavoritesCell"
    
    lazy var coverImageView = DSViewBuilder.buildImageView(cornerRadius: 5, contentMode: .scaleAspectFill)
    
    lazy var nameLabel = DSViewBuilder.buildLabel(font: .preferredFont(forTextStyle: .headline), numberOfLines: 0)
    lazy var summaryLabel = DSViewBuilder.buildLabel(textColor: .secondaryLabel, font: .preferredFont(forTextStyle: .caption2), numberOfLines: 0)
    lazy var VStackView = DSViewBuilder.buildStackView(arrangedSubviews: [nameLabel, summaryLabel], axis: .vertical)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configure(show: Show) {
        guard let url = URL(string: show.imageMedium) else { return }
        
        coverImageView.sd_setImage(with: url)
        nameLabel.text = show.name
        summaryLabel.text = show.summary?.cleanHTML()
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        addSubviews(coverImageView, VStackView)
    }
    
    private func setConstraints() {
        let padding: CGFloat = 12
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),
            
            coverImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            coverImageView.widthAnchor.constraint(equalToConstant: 80),
            coverImageView.heightAnchor.constraint(equalToConstant: 130),
            
            VStackView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            VStackView.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: padding),
            VStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            VStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
        ])
    }
}
