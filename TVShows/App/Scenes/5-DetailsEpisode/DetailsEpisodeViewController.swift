//
//  DetailsEpisodeViewController.swift
//  TVShows
//
//  Created by Diggo Silva on 29/03/25.
//

import UIKit

class DetailsEpisodeViewController: UIViewController {
    
    let detailsEpisodeView = DetailsEpisodeView()
    
    override func loadView() {
        super.loadView()
        view = detailsEpisodeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        detailsEpisodeView.spinner.startAnimating()
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissDetails))
    }
    
    @objc private func dismissDetails() {
        dismiss(animated: true)
    }
}
