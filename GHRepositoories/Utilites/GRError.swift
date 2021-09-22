//
//  GRError.swift
//  GHRepositoories
//
//  Created by ahmed sultan on 20/09/2021.
//

enum GRError: String, Error {
    
    case invalidRepositoryName = "This repository created an invalid request, please try again later."
    case unableToComplete = "Unable to complete your request, please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid, Please try again later."
    case invalidUrl = "This recopsitory could be openned, please try again later."
    case emptyRepositories = "Could not find repositories with this name, please try again with valid name."
    case emptyRepositoryName = "Please enter a repository name. We need to know what to look for 😀."
}
