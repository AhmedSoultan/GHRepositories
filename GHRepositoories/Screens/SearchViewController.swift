//
//  ViewController.swift
//  GHRepositoories
//
//  Created by ahmed sultan on 19/09/2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK:- properties
    
    let searchView = GRSearchView(frame: .zero)

    let coordinator = AppCoordinator.shared
    var isRepositoryNameEntered: Bool { return !searchView.repositoryNameTextField.text!.isEmpty }

    //MARK:- view life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchView()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureViewController()
    }
    
    //MARK:- custom actions

    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func createSearchView() {
        view.addSubview(searchView)
        searchView.backgroundColor = .systemBackground
        searchView.delegate = self
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    fileprivate func pushRepositoriesVC() {
        guard isRepositoryNameEntered else {
            self.coordinator.main.navigate(to: .alert(title: "Empty repository name", message: GRError.emptyRepositoryName.rawValue, buttonTitle: "Ok"), with: .present, and: self.navigationController)
            return
        }
        coordinator.main.navigate(to: .results(repositoryName: searchView.repositoryNameTextField.text!), with: .push, and: self.navigationController)
    }
}

//MARK:- Search View Delegate

extension SearchViewController: SearchViewDelegate {
    
    func searchShouldEndEditting() {
        pushRepositoriesVC()
    }
}

