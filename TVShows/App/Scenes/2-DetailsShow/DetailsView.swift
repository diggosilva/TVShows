//
//  DetailsView.swift
//  TVShows
//
//  Created by Diggo Silva on 24/03/25.
//

import UIKit

class DetailsView: UIView {
    
    lazy var headerView = CastView()
//    lazy var footerView = SeasonView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        backgroundColor = .systemBackground
        addSubviews(headerView /*, footerView*/)
    }
    
    private func setConstraints() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
//        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 100),
            
//            footerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
//            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            footerView.heightAnchor.constraint(equalToConstant: 120),
        ])
    }
}
