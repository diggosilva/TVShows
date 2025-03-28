//
//  EpisodeCell.swift
//  TVShows
//
//  Created by Diggo Silva on 27/03/25.
//

import UIKit
import SDWebImage

class EpisodeCell: UITableViewCell {
    
    static let identifier = "EpisodeCell"
    
    lazy var epImageView = DSViewBuilder.buildImageView(cornerRadius: 5, contentMode: .scaleAspectFill)
    
    lazy var epTitleLabel = DSViewBuilder.buildLabel(font: .preferredFont(forTextStyle: .headline), numberOfLines: 0)
    lazy var epNumberLabel = DSViewBuilder.buildLabel(font: .preferredFont(forTextStyle: .subheadline))
    
    lazy var epRatingImageView = DSViewBuilder.buildImageView(image: SFSymbols.star?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal))
    lazy var epiRatingLabelValue = DSViewBuilder.buildLabel(font: .preferredFont(forTextStyle: .subheadline))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configure(episode: Episode) {
        guard let url = URL(string: episode.image.medium ?? ""),
              let rate = episode.rating else { return }
        
        epImageView.sd_setImage(with: url)
        epTitleLabel.text = episode.name
        epNumberLabel.text = "Episódio \(episode.number)"
        epiRatingLabelValue.text = "\(rate) / 10"
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        addSubviews(epImageView, epTitleLabel, epNumberLabel, epRatingImageView, epiRatingLabelValue)
    }
    
    private func setConstraints() {
        let padding: CGFloat = 12
        NSLayoutConstraint.activate([
            epImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            epImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            epImageView.widthAnchor.constraint(equalToConstant: 80),
            epImageView.heightAnchor.constraint(equalToConstant: 60),
            
            epTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            epTitleLabel.leadingAnchor.constraint(equalTo: epImageView.trailingAnchor, constant: padding),
            epTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            epNumberLabel.topAnchor.constraint(equalTo: epTitleLabel.bottomAnchor, constant: padding),
            epNumberLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            epNumberLabel.leadingAnchor.constraint(equalTo: epImageView.trailingAnchor, constant: padding),
            epNumberLabel.trailingAnchor.constraint(lessThanOrEqualTo: epRatingImageView.leadingAnchor, constant: -padding),
            
            epiRatingLabelValue.centerYAnchor.constraint(equalTo: epNumberLabel.centerYAnchor),
            epiRatingLabelValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            epRatingImageView.centerYAnchor.constraint(equalTo: epNumberLabel.centerYAnchor),
            epRatingImageView.trailingAnchor.constraint(equalTo: epiRatingLabelValue.leadingAnchor, constant: -padding / 2),
        ])
    }
}
