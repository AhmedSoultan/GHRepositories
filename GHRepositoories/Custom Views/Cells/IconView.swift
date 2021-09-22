//
//  FavouriteView.swift
//  GHRepositoories
//
//  Created by ahmed sultan on 19/09/2021.
//

import UIKit

class IconView: UIView {
    
    //MARK:- properties

    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var iconLabel: GRBodyLabel = {
        let label = GRBodyLabel(textAlignment: .natural)

        return label
    }()
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    //MARK:- init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- custom action

    private func configure() {
        self.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            mainStackView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
        configureFavouriteImage()
        configureFavouriteLabel()
    }
    
    private func configureFavouriteImage() {
        mainStackView.addArrangedSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor, multiplier: 1).isActive = true
    }
    
    private func configureFavouriteLabel() {
        mainStackView.addArrangedSubview(iconLabel)
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(iconText: String, iconImage: UIImage?) {
        iconLabel.text = iconText
        iconImageView.image = iconImage
    }
}
