//
//  ItemResponse.swift
//  GHRepositoories
//
//  Created by ahmed sultan on 20/09/2021.
//

import Foundation

struct RepositoryResponse: Codable, Hashable {
    var htmlUrl: String?
    var fullName: String?
    var description: String?
    var updatedAt: Date?
    var language: String?
    var stargazersCount: Int?
        
    var url: URL? {
        guard htmlUrl != nil else { return nil }
        return URL(string: htmlUrl ?? "")
    }
}
