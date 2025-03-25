//
//  DetailsView.swift
//  TVShows
//
//  Created by Diggo Silva on 24/03/25.
//

import UIKit

class DetailsView: UIView {
    
    lazy var castLabel = DSViewBuilder.buildLabel(text: "Elenco", textColor: .secondaryLabel, font: .preferredFont(forTextStyle: .headline))
    lazy var headerView = CastView()
    
    lazy var coverImageView = DSViewBuilder.buildImageView(cornerRadius: 10, borderWidth: 2)
    
    lazy var seasonLabel = DSViewBuilder.buildLabel(text: "Temporadas", textColor: .secondaryLabel, font: .preferredFont(forTextStyle: .headline))
    lazy var footerView = SeasonView()
    
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
        addSubviews(castLabel, headerView, coverImageView, seasonLabel, footerView)
    }
    
    private func setConstraints() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            castLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            castLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            castLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            castLabel.heightAnchor.constraint(equalToConstant: 30),
            
            headerView.topAnchor.constraint(equalTo: castLabel.bottomAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 120),
            
            coverImageView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding * 5),
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding * 5),
            coverImageView.bottomAnchor.constraint(equalTo: seasonLabel.topAnchor, constant: -padding),
            
            seasonLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            seasonLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            seasonLabel.bottomAnchor.constraint(equalTo: footerView.topAnchor),
            seasonLabel.heightAnchor.constraint(equalToConstant: 30),
            
            footerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 120),
        ])
    }
}

//#Preview {
//    let show: Show = .init(id: 1, name: "Test", image: "", rating: nil)
//    DetailsViewController(viewModel: DetailsViewModel(show: show))
//}
