//
//  EpisodesViewController.swift
//  TVShows
//
//  Created by Diggo Silva on 27/03/25.
//

import UIKit

class EpisodesViewController: UIViewController {
    
    let episodesView = EpisodesView()
    let viewModel: EpisodesViewModel
    
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
    
    private func handleStates() {
        viewModel.state.bind { states in
            
            switch states {
            case .loading: self.showLoadingState()
            case .loaded: self.showLoadedState()
            case .error: self.showErrorState()
            }
        }
    }
    
    private func showLoadingState() {
        episodesView.spinner.startAnimating()
        episodesView.loadingLabel.isHidden = false
    }
    
    private func showLoadedState() {
        episodesView.spinner.stopAnimating()
        episodesView.loadingLabel.isHidden = true
        episodesView.tableView.reloadData()
    }
    
    private func showErrorState() {
        presentDSAlert(title: "Ops... algo deu errado", message: "Não foi possível carregar os episódios. Tente novamente mais tarde.") { action in
            print("DEBUG: COMPLICOU")
        }
    }
    
    private func configureDelegatesAndDataSources() {
        episodesView.tableView.delegate = self
        episodesView.tableView.dataSource = self
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
