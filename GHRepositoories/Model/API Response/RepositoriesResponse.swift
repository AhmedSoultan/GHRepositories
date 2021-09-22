//
//  Repository.swift
//  GHRepositoories
//
//  Created by ahmed sultan on 20/09/2021.
//

import Foundation


struct RepositoriesResponse: Codable, Hashable {
    var totalCount: Int?
    var items: [RepositoryResponse]?
}
