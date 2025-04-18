//
//  EpisodesView.swift
//  TVShows
//
//  Created by Diggo Silva on 27/03/25.
//

import UIKit

class EpisodesView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: frame, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: EpisodeCell.identifier)
        tableView.separatorInset = .zero
        return tableView
    }()
    
    lazy var spinner = DSViewBuilder.buildSpinner()
    lazy var loadingLabel = DSViewBuilder.buildLoadingLabel()
    
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
        addSubviews(tableView, spinner, loadingLabel)
    }
    
    private func setConstraints() {
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            loadingLabel.centerXAnchor.constraint(equalTo: spinner.centerXAnchor),
            loadingLabel.topAnchor.constraint(equalTo: spinner.bottomAnchor, constant: padding),
            loadingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            loadingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }
}
