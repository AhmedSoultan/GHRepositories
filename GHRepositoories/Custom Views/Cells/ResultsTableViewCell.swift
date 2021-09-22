//
//  ResultsTableViewCell.swift
//  GHRepositoories
//
//  Created by ahmed sultan on 19/09/2021.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    
    //MARK:- properties

    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    lazy var descriptionLabel: GRBodyLabel = {
        let label = GRBodyLabel(textAlignment: .natural)
        label.textColor = .label
        return label
    }()
    let repositoryNameLabel = GRTitleLabel(textAlignment: .natural, fontSize: 20)
    let detailsView = DetailsView(frame: .zero)
   
    //MARK:- life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:- custom actions

    func configure() {
        self.contentView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            mainStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.93),
            mainStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.93)
        ])
        addMainStackSubViews()
    }
    
    func set(repository: RepositoryResponse) {
        repositoryNameLabel.text = repository.fullName ?? ""
        descriptionLabel.text = repository.description ?? ""
        detailsView.set(repository: repository)
    }
    
    private func addMainStackSubViews() {
        mainStackView.addArrangedSubview(repositoryNameLabel)
        mainStackView.addArrangedSubview(descriptionLabel)
        mainStackView.addArrangedSubview(detailsView)
    }
}
