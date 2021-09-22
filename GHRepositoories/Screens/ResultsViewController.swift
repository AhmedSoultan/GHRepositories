//
//  ResultsViewController.swift
//  GHRepositoories
//
//  Created by ahmed sultan on 19/09/2021.
//

import UIKit

class ResultsViewController: UIViewController {
    
    //MARK:- properties

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
 
    lazy var emptyStateImageView: UIImageView = {
        return UIImageView()
    }()

    let coordinator = AppCoordinator.shared
    var repositories = [RepositoryResponse]()
    var repositoryName: String?
    var provider = RepositoriesProvider()
    var totalCount = 0
    var page = 1
    
    //MARK:- init

    init(repositoryName: String) {
        super.init(nibName: nil, bundle: nil)
        self.repositoryName = repositoryName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- view life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpTableView()
        getRepositories(page: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = repositoryName
    }
    
    //MARK:- custom actions
    
    fileprivate func getRepositories(page: Int) {
        showLoadingView()
        provider.getRepositories(repositoryname: self.repositoryName ?? "", page: page, completion: handleGetRepositoriesResponse(results:))
    }
    
    func handleGetRepositoriesResponse(results: Result<RepositoriesResponse, GRError>) {
        self.removeActivityIndicatorView()
        switch results {
        case .success(let repositories):
            self.totalCount = repositories.totalCount ?? 0
            self.repositories += repositories.items ?? []
            tableView.reloadData()
        case .failure(let error):
            addEmptyStateImageView()
            coordinator.main.navigate(to: .alert(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "Ok"), with: .present, and: navigationController)
        }
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(ResultsTableViewCell.self, forCellReuseIdentifier: String(describing: ResultsTableViewCell.self))
    }
    
    fileprivate func setUpTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        configureTableView()
    }
    
    fileprivate func addEmptyStateImageView() {
        self.view.addSubview(emptyStateImageView)
        self.emptyStateImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyStateImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            emptyStateImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            emptyStateImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7),
            emptyStateImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5)
        ])
        emptyStateImageView.image = Image.emptyStateLogo
    }
}

//MARK:- table View data source

extension ResultsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == repositories.count - 1 && repositories.count < totalCount {
            page += 1
            getRepositories(page: page)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ResultsTableViewCell.self), for: indexPath) as! ResultsTableViewCell
        cell.configure()
        cell.set(repository: repositories[indexPath.row])
        return cell
    }
}

//MARK:- table View Delegate

extension ResultsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.isSelected.toggle()
        }
        guard let url = repositories[indexPath.row].url else {
            coordinator.main.navigate(to: .alert(title: "Bad Stuff Happend", message: GRError.invalidUrl.rawValue, buttonTitle: "Ok"), with: .present, and: self.navigationController)
            return
        }
        coordinator.main.navigate(to: .safari(url: url), with: .present, and: self.navigationController)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

