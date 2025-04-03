//
//  ViewController.swift
//  TVShows
//
//  Created by Diggo Silva on 21/03/25.
//

import UIKit

class FeedViewController: UIViewController {
    
    let feedView = FeedView()
    var viewModel: FeedViewModelProtocol
    
    init(viewModel: FeedViewModelProtocol = FeedViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        super.loadView()
        view = feedView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureDelegates()
        configureDataSource()
        handleStates()
        viewModel.fetchShows()
    }
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if viewModel.numberOfItemsInSection() == 0 && !feedView.spinner.isAnimating {
            var config = UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: "movieclapper")
            config.text = "Sem Séries"
            config.secondaryText = "Não há séries com o título informado."
            contentUnavailableConfiguration = config
        } else {
            contentUnavailableConfiguration = nil
        }
    }
    
    func handleStates() {
        viewModel.observeState { [weak self] state in
            switch state {
            case .loading: self?.showLoadingState()
            case .loaded: self?.showLoadedState()
            case .error: self?.showErrorState()
            case .showsFiltered(let shows): self?.updateData(on: shows)
            }
        }
    }
    
    private func showLoadingState() { handleSpinner(isLoading: true) }
    
    private func showLoadedState() { handleSpinner(isLoading: false) }
    
    private func showErrorState() {
        presentDSAlert(title: "Ops... algo deu errado!", message: DSError.networkError.rawValue) { action in
            self.handleSpinner(isLoading: false)
        }
    }
    
    func handleSpinner(isLoading: Bool) {
        if isLoading {
            feedView.spinner.startAnimating()
            feedView.loadingLabel.isHidden = false
        } else {
            feedView.spinner.stopAnimating()
            feedView.loadingLabel.isHidden = true
            feedView.collectionView.reloadData()
            setNeedsUpdateContentUnavailableConfiguration()
        }
    }
    
    private func configureNavigationBar() { title = "TV Shows" }
    
    private func configureDelegates() {
        feedView.collectionView.delegate = self
        feedView.searchBar.delegate = self
    }
    
    private func configureDataSource() {
        feedView.dataSource = UICollectionViewDiffableDataSource<Section, Show>(collectionView: feedView.collectionView, cellProvider: { (collectionView, indexPath, show) -> UICollectionViewCell in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.identifier, for: indexPath) as? FeedCell else { return UICollectionViewCell() }
            cell.configure(show: show)
            return cell
        })
    }
    
    private func updateData(on shows: [Show])  {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Show>()
        snapshot.appendSections([.main])
        snapshot.appendItems(shows)
        DispatchQueue.main.async {
            self.feedView.dataSource.apply(snapshot, animatingDifferences: true)
        }
        setNeedsUpdateContentUnavailableConfiguration()
    }
}

extension FeedViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let show = viewModel.cellForItem(at: indexPath)
       
        guard let url = URL(string: show.originalImage) else { return }
       
        let detailVC = DetailsViewController(viewModel: DetailsViewModel(show: show))
        detailVC.title = show.name
        detailVC.detailsView.coverImageView.sd_setImage(with: url)
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension FeedViewController: UISearchBarDelegate {
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchBar(textDidChange: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

//MARK: SEARCH BAR
extension FeedViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            viewModel.searchBar(textDidChange: "")
            return
        }
        
        viewModel.searchBar(textDidChange: filter)
    }
}
