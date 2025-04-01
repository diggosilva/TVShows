//
//  DetailsEpisodeView.swift
//  TVShows
//
//  Created by Diggo Silva on 29/03/25.
//

import UIKit
import SDWebImage

class DetailsEpisodeView: UIView {
    
    lazy var episodeImage = DSViewBuilder.buildImageView(image: SFSymbols.popcorn, cornerRadius: 10, borderWidth: 2)
    
    lazy var airDateLAbel = DSViewBuilder.buildLabel(font: .preferredFont(forTextStyle: .caption1))
    lazy var airTimeLabel = DSViewBuilder.buildLabel(font: .preferredFont(forTextStyle: .caption1))
    lazy var hStackView = DSViewBuilder.buildStackView(arrangedSubviews: [airDateLAbel, airTimeLabel])
    
    lazy var summaryLabel = DSViewBuilder.buildLabel(textColor: .secondaryLabel, textAlignment: .left, font: .preferredFont(forTextStyle: .subheadline), numberOfLines: 0)
    lazy var spinner = DSViewBuilder.buildSpinner()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configure(episode: Episode) {
        guard let url = URL(string: episode.originalImage ?? "") else { return }
        
        episodeImage.sd_setImage(with: url, completed: { [weak self] image, error, cacheType, url in
            self?.spinner.stopAnimating()
            self?.spinner.hidesWhenStopped = true
            
            DispatchQueue.main.async {
                self?.airDateLAbel.text = "Exibido em: \(self?.formatBirthday(episode.airdate) ?? "N/A")"
                self?.airTimeLabel.text = "Horário: \(episode.airtime)"
                self?.summaryLabel.text = episode.cleanSummary
            }
        })
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        backgroundColor = .systemBackground
        addSubviews(episodeImage, hStackView, summaryLabel, spinner)
    }
    
    private func setConstraints() {
        let padding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            episodeImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding),
            episodeImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            episodeImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            episodeImage.heightAnchor.constraint(equalToConstant: 200),
            
            hStackView.topAnchor.constraint(equalTo: episodeImage.bottomAnchor, constant: padding),
            hStackView.leadingAnchor.constraint(equalTo: episodeImage.leadingAnchor),
            hStackView.trailingAnchor.constraint(equalTo: episodeImage.trailingAnchor),
            
            summaryLabel.topAnchor.constraint(equalTo: hStackView.bottomAnchor, constant: padding),
            summaryLabel.leadingAnchor.constraint(equalTo: episodeImage.leadingAnchor),
            summaryLabel.trailingAnchor.constraint(equalTo: episodeImage.trailingAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: episodeImage.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: episodeImage.centerYAnchor)
        ])
    }
}
