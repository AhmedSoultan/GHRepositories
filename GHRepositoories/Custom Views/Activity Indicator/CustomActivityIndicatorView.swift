//
//  CustomActivityIndicatorView.swift
//  GHRepositoories
//
//  Created by ahmed sultan on 21/09/2021.
//

import UIKit
class CustomActivityIndicatorView: UIView {
    
    //MARK:- Properties

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.style  = .large
        activityIndicator.backgroundColor = .systemGray
        activityIndicator.color  = .systemGreen
        activityIndicator.layer.cornerRadius = 10
        activityIndicator.layer.masksToBounds = true
        return activityIndicator
    }()
    
    //MARK:- Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Custom action

    func configure() {
        self.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.heightAnchor.constraint(equalToConstant: 70).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 70).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
