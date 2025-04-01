//
//  FavoritesViewController.swift
//  TVShows
//
//  Created by Diggo Silva on 01/04/25.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    let favoritesView = FavoritesView()
    var viewModel: FavoritesViewModelProtocol
    
    override func loadView() {
        super.loadView()
        view = favoritesView
    }
    
    init(viewModel: FavoritesViewModelProtocol = FavoritesViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureDelegatesAndDataSources()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadShows()
        setNeedsUpdateContentUnavailableConfiguration()
    }
    
    private func configureNavigationBar() {
        title = "Favoritos"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureDelegatesAndDataSources() {
        favoritesView.tableView.delegate = self
        favoritesView.tableView.dataSource = self
        viewModel.delegate = self
    }
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if viewModel.numberOfRowsInSection() == 0 {
            var config = UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: "star")
            config.text = "Sem Favoritos ainda"
            config.secondaryText = "Sua lista de séries favoritas aparecerá aqui."
            contentUnavailableConfiguration = config
        } else {
            contentUnavailableConfiguration = nil
        }
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.identifier, for: indexPath) as? FavoritesCell else { return UITableViewCell() }
        let show = viewModel.cellForRow(at: indexPath)
        cell.configure(show: show)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let show = viewModel.cellForRow(at: indexPath)
        guard let url = URL(string: show.imageLarge) else { return }
        
        let detailVC = DetailsViewController(viewModel: DetailsViewModel(show: show))
        detailVC.title = show.name
        detailVC.detailsView.coverImageView.sd_setImage(with: url)
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.shows.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            viewModel.saveShows()
            setNeedsUpdateContentUnavailableConfiguration()
        }
    }
}

extension FavoritesViewController: FavoritesViewModelDelegate {
    func reloadTable() {
        favoritesView.tableView.reloadData()
        print("DEBUG: Carregou")
    }
}
