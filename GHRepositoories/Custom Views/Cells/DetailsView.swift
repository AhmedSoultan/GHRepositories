//
//  DetailsView.swift
//  GHRepositoories
//
//  Created by ahmed sultan on 19/09/2021.
//


import UIKit

class DetailsView: UIView {
    
    //MARK:- properties

    lazy var updateDateLabel = GRBodyLabel(textAlignment: .center)
    let favouriteView = IconView(frame: .zero)
    let languageView = IconView(frame: .zero)
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    lazy var iconsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
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
    
    //MARK:- custom actions
    
    private func configure() {
        self.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            mainStackView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
        addMainStackSubViews()
    }
    
    private func configureIconsStackView() {
        iconsStackView.addArrangedSubview(favouriteView)
        iconsStackView.addArrangedSubview(languageView)
        favouriteView.translatesAutoresizingMaskIntoConstraints = false
        languageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addMainStackSubViews() {
        mainStackView.addArrangedSubview(iconsStackView)
        iconsStackView.translatesAutoresizingMaskIntoConstraints = false
        iconsStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.5).isActive = true
        configureIconsStackView()
        mainStackView.addArrangedSubview(updateDateLabel)
        updateDateLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(repository: RepositoryResponse) {
        self.favouriteView.set(iconText: "\(repository.stargazersCount ?? 0)", iconImage: Image.favourite)
        self.languageView.set(iconText: repository.language ?? "", iconImage: Image.language)
        self.updateDateLabel.text = "Updated on  \(repository.updatedAt?.convertToMonthYearFormat() ?? "")"
    }
}
