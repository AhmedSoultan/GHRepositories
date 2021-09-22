//
//  MainNavigator.swift
//  GHRepositoories
//
//  Created by ahmed sultan on 19/09/2021.
//

import UIKit
import SafariServices

class MainNavigator: Navigator {
        
    enum Destination {
        case search
        case results(repositoryName: String)
        case safari(url:URL)
        case alert(title: String, message: String, buttonTitle: String)
    }
    
    func viewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .search:
            return SearchViewController()
        case let .results(repositoryName):
            return ResultsViewController(repositoryName: repositoryName)
        case let .alert(title, message, buttonTitle):
            let alertVC = GRAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overCurrentContext
            alertVC.modalTransitionStyle = .crossDissolve
            return alertVC
        case .safari(url: let url):
            let safariViewController = SFSafariViewController(url: url)
            return safariViewController
        }
    }
}
