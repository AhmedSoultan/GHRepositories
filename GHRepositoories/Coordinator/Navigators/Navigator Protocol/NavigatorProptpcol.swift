//
//  NavigatorProptpcol.swift
//  GHRepositoories
//
//  Created by ahmed sultan on 19/09/2021.
//


import UIKit
enum NavigationType {
    case push
    case present
    case root
}

protocol Navigator {
    
    associatedtype Destination
    
    func viewController(for destination: Destination) -> UIViewController
    
    func navigate(to destination: Destination, with navigationTpe: NavigationType, and navigationController: UINavigationController?)
}

extension Navigator {
    
    func navigate(to destination: Destination, with navigationTpe: NavigationType, and navigationController: UINavigationController?) {
        switch navigationTpe {
        case .push:
            navigationController?.pushViewController(self.viewController(for: destination), animated: true)
        case .present:
            navigationController?.present(self.viewController(for: destination), animated: true, completion: nil)
        case .root:
            navigationController?.setViewControllers([self.viewController(for: destination)], animated: true)
        }
    }
}
