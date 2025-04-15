//
//  FeedCell.swift
//  TVShows
//
//  Created by Diggo Silva on 23/03/25.
//

import UIKit
import SDWebImage

class FeedCell: UICollectionViewCell {
    
    static let identifier = "FeedCell"
    
    lazy var coverImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    func configure(show: Show) {
        guard let url = URL(string: show.mediumImage ?? "") else { return }
        
        coverImageView.sd_setImage(with: url)
        applyShadow(view: self)
    }
    
    private func setHierarchy() {
        addSubviews(coverImageView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
