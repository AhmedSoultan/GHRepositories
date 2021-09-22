//
//  RepositoriesProvider.swift
//  GHRepositoories
//
//  Created by ahmed sultan on 20/09/2021.
//

import UIKit

class RepositoriesProvider {
    
    private var grClient = GRClient.shared
    private var parser = GRParser()
    
    func getRepositories(repositoryname: String, page: Int, completion: @escaping (Result<RepositoriesResponse, GRError>) -> Void) {
        grClient.getRepositories(for: repositoryname, page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let jsonObject):
                    guard let repositories = self.parser.parse(jsonObject, responseType: RepositoriesResponse.self) else {
                        completion(.failure(.invalidData))
                        return
                    }
                    guard repositories.items?.isEmpty == false else {
                        completion(.failure(.emptyRepositories))
                        return
                    }
                    completion(.success(repositories))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
