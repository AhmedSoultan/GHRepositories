//
//  AppCoordinator.swift
//  GHRepositoories
//
//  Created by ahmed sultan on 19/09/2021.
//


import UIKit

class AppCoordinator {
    
    //MARK:- properties
    
    static var shared = AppCoordinator()
    
    lazy var main: MainNavigator = {
        return MainNavigator()
    }()

    //MARK:- life cycle
    private init() {
    }
    
    //MARK:- custom action
    func start(with window: UIWindow?) {
        
        window?.rootViewController = rootViewController()
        window?.makeKeyAndVisible()
    }
    func rootViewController() -> UIViewController {
        let rootVC = main.viewController(for: .search)
        let naviagationController = UINavigationController(rootViewController: rootVC)
        UINavigationBar.appearance().tintColor = .systemGreen
        return naviagationController
    }
}
