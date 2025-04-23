//
//  FeedView.swift
//  TVShows
//
//  Created by Diggo Silva on 23/03/25.
//

import UIKit

enum Section {
    case main
}

class FeedView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let padding: CGFloat = 10
        let widthScreen = (UIScreen.main.bounds.width) / 3.5
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding + 20, right: padding)
        layout.itemSize = CGSize(width: widthScreen, height: widthScreen * 1.5)
        layout.minimumLineSpacing = 15
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.identifier)
        return cv
    }()
    
    lazy var bgSpinnerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .label
        view.isHidden = true
        view.alpha = 0.25
        return view
    }()
    
    lazy var spinner = DSViewBuilder.buildSpinner(color: .systemBackground)
    lazy var loadingLabel = DSViewBuilder.buildLoadingLabel(color: .systemBackground)
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Show>!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
        
    private func setupView() {
        backgroundColor = .systemBackground
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        addSubviews(collectionView, bgSpinnerView, spinner, loadingLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([            
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            bgSpinnerView.topAnchor.constraint(equalTo: topAnchor),
            bgSpinnerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgSpinnerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgSpinnerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: bgSpinnerView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: bgSpinnerView.centerYAnchor),
            
            loadingLabel.centerXAnchor.constraint(equalTo: spinner.centerXAnchor),
            loadingLabel.topAnchor.constraint(equalTo: spinner.bottomAnchor),
            loadingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
