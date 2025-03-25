//
//  CastCell.swift
//  TVShows
//
//  Created by Diggo Silva on 24/03/25.
//

import UIKit
import SDWebImage

class CastCell: UICollectionViewCell {
    
    static let identifier = "CastCell"
    
    lazy var imageView = DSViewBuilder.buildImageView(cornerRadius: 40, borderWidth: 2)    
    lazy var nameLabel = DSViewBuilder.buildLabel(textAlignment: .center, font: .preferredFont(forTextStyle: .footnote))
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configure(cast: Cast) {
        guard let imageMedium = cast.image.medium,
              let url = URL(string: imageMedium) else { return }
        
        imageView.sd_setImage(with: url)
        nameLabel.text = cast.name
        
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        addSubviews(imageView, nameLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

//#Preview {
//    let show: Show = .init(id: 1, name: "Test", image: "", imageLarge: "", rating: nil)
//    DetailsViewController(viewModel: DetailsViewModel(show: show))
//}
