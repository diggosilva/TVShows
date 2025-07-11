//
//  DetailsViewController.swift
//  TVShows
//
//  Created by Diggo Silva on 24/03/25.
//

import UIKit
import Combine

class DetailsViewController: UIViewController {
    
    let detailsView = DetailsView()
    var viewModel: any DetailsViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: any DetailsViewModelProtocol) {
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
        handleStates()
        viewModel.fetchCast()
        viewModel.fetchSeasons()
    }
    
    private func handleStates() {
        viewModel.statePublisher
            .receive(on: RunLoop.main)
            .sink { state in
                switch state {
                case .loading: self.showLoadingState()
                case .loaded: self.showLoadedState()
                case .error: self.showErrorState()
                case .showAlert(title: let title, message: let message):
                    self.showAlertState(title: title, message: message)
                }
            }.store(in: &cancellables)
    }
    
    private func showLoadingState() {
        handleSpinner(isLoading: true)
    }
    
    private func showLoadedState() {
        handleSpinner(isLoading: false)
    }
    
    private func showErrorState() {
        presentDSAlert(title: "Ops... algo deu errado!", message: DSError.networkError.rawValue) { action in
            self.handleSpinner(isLoading: false)
        }
    }
    
    private func showAlertState(title: String, message: String) {
        presentDSAlert(title: title, message: message)
    }
    
    func handleSpinner(isLoading: Bool) {
        if isLoading {
            detailsView.headerView.spinner.startAnimating()
            detailsView.footerView.spinner.startAnimating()
            
            detailsView.headerView.loadingLabel.isHidden = false
            detailsView.footerView.loadingLabel.isHidden = false
            
        } else {
            detailsView.headerView.spinner.stopAnimating()
            detailsView.footerView.spinner.stopAnimating()
            
            detailsView.headerView.loadingLabel.isHidden = true
            detailsView.footerView.loadingLabel.isHidden = true
            
            detailsView.headerView.collectionView.reloadData()
            detailsView.footerView.collectionView.reloadData()
        }
    }
    
    @objc private func addFavoriteTapped() {
        let show = viewModel.getShow()
        viewModel.addShowToFavorite(show: show) { result in }
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFavoriteTapped))
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func configureDelegatesAndDataSources() {
        detailsView.headerView.collectionView.delegate = self
        detailsView.headerView.collectionView.dataSource = self
        
        detailsView.footerView.collectionView.delegate = self
        detailsView.footerView.collectionView.dataSource = self
    }
}

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == detailsView.headerView.collectionView {
            return viewModel.numberOfItemsInSection()
        } else if collectionView == detailsView.footerView.collectionView {
            return viewModel.numberOfSeasonsInSection()
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == detailsView.headerView.collectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCell.identifier, for: indexPath) as? CastCell else { return UICollectionViewCell() }
            cell.configure(cast: viewModel.castForItem(at: indexPath))
            return cell
            
        } else if collectionView == detailsView.footerView.collectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeasonCell.identifier, for: indexPath) as? SeasonCell else { return UICollectionViewCell() }
            cell.configure(season: viewModel.seasonForItem(at: indexPath))
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == detailsView.headerView.collectionView {
            let cast = viewModel.castForItem(at: indexPath)
            
            let characterVC = CharacterViewController()
            characterVC.title = cast.name
            characterVC.characterView.configure(person: cast)
            navigationController?.pushViewController(characterVC, animated: true)
            
        } else if collectionView == detailsView.footerView.collectionView {
            
            if collectionView == detailsView.footerView.collectionView {
                let show = viewModel.getShow()
                let seasonNumber = indexPath.item + 1
                
                let episodeVC = EpisodesViewController(viewModel: EpisodesViewModel(show: show, season: seasonNumber))
                episodeVC.title = "Temporada \(indexPath.item + 1)"
                navigationController?.pushViewController(episodeVC, animated: true)
            }
        }
    }
}
