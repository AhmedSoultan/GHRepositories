//
//  GRClient.swift
//  GHRepositoories
//
//  Created by ahmed sultan on 20/09/2021.
//

import Foundation

class GRClient {
    
    static let shared   = GRClient()
    
    private let baseURL = "https://api.github.com/search/repositories"
    
    private init() {}
    
    
    func getRepositories(for repositoryName: String, page: Int, completion: @escaping (Result<[String: Any], GRError>) -> Void) {
        
        let endpoint = baseURL + "?q=\(repositoryName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&per_page=30&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidRepositoryName))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let grError = self.handleErrors(data: data, response: response, error: error) {
                completion(.failure(grError))
            }
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data!, options: [])
                if let jsonDict: [String: Any] = jsonObject as? [String: Any] {
                    completion(.success(jsonDict))
                }
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    private func handleErrors(data: Data?, response: URLResponse?, error: Error?) -> GRError? {
        if let _ = error {
            return .unableToComplete
        }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            return .invalidResponse
        }
        guard let _ = data else {
            return .invalidData
        }
        return nil
    }
}
