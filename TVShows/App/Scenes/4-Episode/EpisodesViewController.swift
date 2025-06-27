//
//  EpisodesViewController.swift
//  TVShows
//
//  Created by Diggo Silva on 27/03/25.
//

import UIKit
import Combine

class EpisodesViewController: UIViewController {
    
    let episodesView = EpisodesView()
    let viewModel: EpisodesViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: EpisodesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        super.loadView()
        view = episodesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDelegatesAndDataSources()
        handleStates()
        viewModel.fetchEpisodes()
    }
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if viewModel.numberOfRowsInSection() == 0 && !episodesView.spinner.isAnimating {
            var config = UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: "movieclapper")
            config.text = "Sem Episódios"
            config.secondaryText = "Não foi possível carregar os episódios dessa séries."
            contentUnavailableConfiguration = config
        } else {
            contentUnavailableConfiguration = nil
        }
    }
    
    private func handleStates() {
        viewModel.statePublisher
            .receive(on: RunLoop.main)
            .sink { state in
                switch state {
                case .loading: self.showLoadingState()
                case .loaded: self.showLoadedState()
                case .error: self.showErrorState()
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
        presentDSAlert(title: "Ops... algo deu errado", message: "Não foi possível carregar os episódios. Tente novamente mais tarde.") { action in
            self.handleSpinner(isLoading: false)
        }
    }
    
    private func configureDelegatesAndDataSources() {
        episodesView.tableView.delegate = self
        episodesView.tableView.dataSource = self
    }
    
    func handleSpinner(isLoading: Bool) {
        if isLoading {
            episodesView.spinner.startAnimating()
            episodesView.loadingLabel.isHidden = false
        } else {
            episodesView.spinner.stopAnimating()
            episodesView.loadingLabel.isHidden = true
            episodesView.tableView.reloadData()
            setNeedsUpdateContentUnavailableConfiguration()
        }
    }
}

extension EpisodesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeCell.identifier, for: indexPath) as? EpisodeCell else { return UITableViewCell() }
        cell.configure(episode: viewModel.cellForRow(at: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let episode = viewModel.cellForRow(at: indexPath)
        let detailsEpisodeVC = DetailsEpisodeViewController()
        let navController = UINavigationController(rootViewController: detailsEpisodeVC)
        
        detailsEpisodeVC.title = episode.name
        detailsEpisodeVC.detailsEpisodeView.configure(episode: episode)
        present(navController, animated: true)
    }
}
