//
//  SeasonView.swift
//  TVShows
//
//  Created by Diggo Silva on 24/03/25.
//

import UIKit

class SeasonView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createSectionLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(SeasonCell.self, forCellWithReuseIdentifier: SeasonCell.identifier)
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = false
        return cv
    }()
    
    lazy var spinner = DSViewBuilder.buildSpinner(style: .medium)
    lazy var loadingLabel = DSViewBuilder.buildLoadingLabel()
    
    private var cellsItemHeight: NSCollectionLayoutDimension = .absolute(100)
    private var padding: CGFloat = 10
    private lazy var contentInsets = NSDirectionalEdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func createSectionLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: cellsItemHeight)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension: cellsItemHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = padding
        section.contentInsets = contentInsets
        section.orthogonalScrollingBehavior = .groupPaging
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
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
