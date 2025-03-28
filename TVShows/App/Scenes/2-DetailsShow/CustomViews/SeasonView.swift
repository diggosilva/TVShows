//
//  SeasonView.swift
//  TVShows
//
//  Created by Diggo Silva on 24/03/25.
//

import UIKit

class SeasonView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let padding: CGFloat = 10
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.itemSize = CGSize(width: 300, height: 100)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(SeasonCell.self, forCellWithReuseIdentifier: SeasonCell.identifier)
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    lazy var spinner = DSViewBuilder.buildSpinner(style: .medium)
    lazy var loadingLabel = DSViewBuilder.buildLoadingLabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        addSubviews(collectionView, spinner, loadingLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            loadingLabel.centerXAnchor.constraint(equalTo: spinner.centerXAnchor),
            loadingLabel.topAnchor.constraint(equalTo: spinner.bottomAnchor),
            loadingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
