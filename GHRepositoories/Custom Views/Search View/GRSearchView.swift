//
//  GRSearchView.swift
//  GHRepositoories
//
//  Created by ahmed sultan on 19/09/2021.
//

import UIKit


class GRSearchView: UIView {
    
    //MARK:- properties
    
    let logoImageView = UIImageView()
    let repositoryNameTextField = GRTextField()
    let actionButton  = GRButton(backgroundColor: .systemGreen, title: "Get Repositories")
    var delegate: SearchViewDelegate?
   
    //MARK:- initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- custom actions

    private func configureLogoImageView() {
        self.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Image.ghLogo
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureTextField() {
        self.addSubview(repositoryNameTextField)
        repositoryNameTextField.delegate = self
        NSLayoutConstraint.activate([
            repositoryNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            repositoryNameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            repositoryNameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            repositoryNameTextField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func configureCallToActionButton() {
        self.addSubview(actionButton)
        actionButton.addTarget(self, action: #selector(callToActionButton), for: .touchUpInside)
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            actionButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            actionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            actionButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    @objc func callToActionButton() {
        delegate?.searchShouldEndEditting()
    }
}

extension GRSearchView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.searchShouldEndEditting()
        return true
    }
}
