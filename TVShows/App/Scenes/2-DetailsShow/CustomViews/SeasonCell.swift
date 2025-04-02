//
//  SeasonCell.swift
//  TVShows
//
//  Created by Diggo Silva on 24/03/25.
//

import UIKit
import SDWebImage

class SeasonCell: UICollectionViewCell {
    
    static let identifier = "SeasonCell"
    
    lazy var imageView = DSViewBuilder.buildImageView(cornerRadius: 10)
    lazy var seasonsLabel = DSViewBuilder.buildLabel(font: .preferredFont(forTextStyle: .headline))
    lazy var episodesLabel = DSViewBuilder.buildLabel(font: .preferredFont(forTextStyle: .title1))
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configure(season: Season) {
        guard let url = URL(string: season.mediumImage) else { return }
        
        imageView.sd_setImage(with: url)
        seasonsLabel.text = "Temporada \(season.number)"
        episodesLabel.text = "\(season.episodeCount) Episódios"
        
        setupLayoutCell()
    }

    private func setupLayoutCell() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray3.cgColor
        layer.cornerRadius = 10
        backgroundColor = .secondarySystemBackground
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        addSubviews(imageView, seasonsLabel, episodesLabel)
    }
    
    private func setConstraints() {
        let padding: CGFloat = 15
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            seasonsLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: padding),
            seasonsLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: padding / 2),
            seasonsLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            episodesLabel.leadingAnchor.constraint(equalTo: seasonsLabel.leadingAnchor),
            episodesLabel.trailingAnchor.constraint(equalTo: seasonsLabel.trailingAnchor),
            episodesLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -padding)
        ])
    }
}
