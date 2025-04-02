//
//  CharacterView.swift
//  TVShows
//
//  Created by Diggo Silva on 26/03/25.
//

import UIKit
import SDWebImage

class CharacterView: UIView {
    
    lazy var imageView = DSViewBuilder.buildImageView(cornerRadius: 10, borderWidth: 2)
    
    lazy var bg1 = DSViewBuilder.buildBGView()
    lazy var labelBirthday = DSViewBuilder.buildLabelChar(text: "ANIVERSÁRIO")
    lazy var labelBirthdayResult = DSViewBuilder.buildLabelValueChar()
    
    lazy var bg2 = DSViewBuilder.buildBGView()
    lazy var labelAge = DSViewBuilder.buildLabelChar(text: "IDADE")
    lazy var labelAgeResult = DSViewBuilder.buildLabelValueChar()
    
    lazy var bg3 = DSViewBuilder.buildBGView()
    lazy var labelGender = DSViewBuilder.buildLabelChar(text: "GÊNERO")
    lazy var labelGenderResult = DSViewBuilder.buildLabelValueChar()
    
    lazy var bg4 = DSViewBuilder.buildBGView()
    lazy var labelCountry = DSViewBuilder.buildLabelChar(text: "PAÍS")
    lazy var labelCountryResult = DSViewBuilder.buildLabelValueChar()
    
    lazy var spinner = DSViewBuilder.buildSpinner()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configure(person: Cast) {
        guard let url = URL(string: person.image.original ?? "") else { return }
        
        imageView.sd_setImage(with: url, completed: { [weak self] image, error, cacheType, url in
            self?.spinner.stopAnimating()
            self?.spinner.hidesWhenStopped = true
            
            DispatchQueue.main.async {
                self?.labelCountryResult.text = "\(person.countryName) - \(person.countryCode)"
                self?.labelBirthdayResult.text = self?.formatBirthday(person.birth)
                self?.labelAgeResult.text = "\(self?.calculateAge(from: person.birth) ?? 0) anos"
                
                self?.labelGenderResult.text = person.realGender
            }
        })
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        backgroundColor = .systemBackground
        addSubviews(imageView,
                    bg1, labelBirthday, labelBirthdayResult, bg2, labelAge, labelAgeResult,
                    bg3, labelGender, labelGenderResult, bg4, labelCountry, labelCountryResult, spinner)
    }
    
    private func setConstraints() {
        let padding: CGFloat = 10
        let paddingLabel: CGFloat = 2
        let paddingYLabelResult: CGFloat = 15
 
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            imageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300),
            imageView.bottomAnchor.constraint(lessThanOrEqualTo: bg1.topAnchor, constant: -padding),
            
            spinner.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
           
            bg1.bottomAnchor.constraint(equalTo: bg3.topAnchor, constant: -padding),
            bg1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            bg1.widthAnchor.constraint(equalToConstant: 180),
            bg1.heightAnchor.constraint(equalToConstant: 120),
            
            labelBirthday.leadingAnchor.constraint(equalTo: bg1.leadingAnchor, constant: paddingLabel),
            labelBirthday.trailingAnchor.constraint(equalTo: bg1.trailingAnchor, constant: -paddingLabel),
            labelBirthday.bottomAnchor.constraint(equalTo: bg1.bottomAnchor, constant: -paddingLabel),
            
            labelBirthdayResult.centerXAnchor.constraint(equalTo: bg1.centerXAnchor),
            labelBirthdayResult.centerYAnchor.constraint(equalTo: bg1.centerYAnchor, constant: -paddingYLabelResult),
            labelBirthdayResult.leadingAnchor.constraint(equalTo: bg1.leadingAnchor, constant: padding),
            labelBirthdayResult.trailingAnchor.constraint(equalTo: bg1.trailingAnchor, constant: -padding),
            
            
            bg2.bottomAnchor.constraint(equalTo: bg4.topAnchor, constant: -padding),
            bg2.leadingAnchor.constraint(equalTo: bg1.trailingAnchor, constant: padding),
            bg2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            bg2.widthAnchor.constraint(equalTo: bg1.widthAnchor),
            bg2.heightAnchor.constraint(equalTo: bg1.heightAnchor),
            
            labelAge.leadingAnchor.constraint(equalTo: bg2.leadingAnchor, constant: paddingLabel),
            labelAge.trailingAnchor.constraint(equalTo: bg2.trailingAnchor, constant: -paddingLabel),
            labelAge.bottomAnchor.constraint(equalTo: bg2.bottomAnchor, constant: -paddingLabel),
            
            labelAgeResult.centerXAnchor.constraint(equalTo: bg2.centerXAnchor),
            labelAgeResult.centerYAnchor.constraint(equalTo: bg2.centerYAnchor, constant: -paddingYLabelResult),
            labelAgeResult.leadingAnchor.constraint(equalTo: bg2.leadingAnchor, constant: padding),
            labelAgeResult.trailingAnchor.constraint(equalTo: bg2.trailingAnchor, constant: -padding),
            
            
            bg3.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            bg3.leadingAnchor.constraint(equalTo: bg1.leadingAnchor),
            bg3.widthAnchor.constraint(equalToConstant: 180),
            bg3.heightAnchor.constraint(equalTo: bg1.heightAnchor),
            
            labelGender.leadingAnchor.constraint(equalTo: bg3.leadingAnchor, constant: paddingLabel),
            labelGender.trailingAnchor.constraint(equalTo: bg3.trailingAnchor, constant: -paddingLabel),
            labelGender.bottomAnchor.constraint(equalTo: bg3.bottomAnchor, constant: -paddingLabel),
            
            labelGenderResult.centerXAnchor.constraint(equalTo: bg3.centerXAnchor),
            labelGenderResult.centerYAnchor.constraint(equalTo: bg3.centerYAnchor, constant: -paddingYLabelResult),
            labelGenderResult.leadingAnchor.constraint(equalTo: bg3.leadingAnchor, constant: padding),
            labelGenderResult.trailingAnchor.constraint(equalTo: bg3.trailingAnchor, constant: -padding),
            
            
            bg4.bottomAnchor.constraint(equalTo: bg3.bottomAnchor),
            bg4.leadingAnchor.constraint(equalTo: bg3.trailingAnchor, constant: padding),
            bg4.trailingAnchor.constraint(equalTo: bg2.trailingAnchor),
            bg4.widthAnchor.constraint(equalTo: bg1.widthAnchor),
            bg4.heightAnchor.constraint(equalTo: bg1.heightAnchor),
            
            labelCountry.leadingAnchor.constraint(equalTo: bg4.leadingAnchor, constant: paddingLabel),
            labelCountry.trailingAnchor.constraint(equalTo: bg4.trailingAnchor, constant: -paddingLabel),
            labelCountry.bottomAnchor.constraint(equalTo: bg4.bottomAnchor, constant: -paddingLabel),
            
            labelCountryResult.centerXAnchor.constraint(equalTo: bg4.centerXAnchor),
            labelCountryResult.centerYAnchor.constraint(equalTo: bg4.centerYAnchor, constant: -paddingYLabelResult),
            labelCountryResult.leadingAnchor.constraint(equalTo: bg4.leadingAnchor, constant: padding),
            labelCountryResult.trailingAnchor.constraint(equalTo: bg4.trailingAnchor, constant: -padding),
        ])
    }
}
