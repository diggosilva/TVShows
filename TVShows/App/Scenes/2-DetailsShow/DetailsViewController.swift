//
//  DetailsViewController.swift
//  TVShows
//
//  Created by Diggo Silva on 24/03/25.
//

import UIKit

class DetailsViewController: UIViewController {
    
    let detailsView = DetailsView()
    let viewModel: DetailsViewModelProtocol
    
    init(viewModel: DetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        super.loadView()
        view = detailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureDelegatesAndDataSources()
    }
    
    private func configureNavigationBar() {
        title = "Nome do Filme"
    }
    
    private func configureDelegatesAndDataSources() {
        detailsView.headerView.collectionView.delegate = self
        detailsView.headerView.collectionView.dataSource = self
        
//        detailsView.footerView.collectionView.delegate = self
//        detailsView.footerView.collectionView.dataSource = self
    }
}

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCell.identifier, for: indexPath) as? CastCell else { return UICollectionViewCell() }
        cell.configure(cast: viewModel.cellForItem(at: indexPath))
        return cell
    }
}
