//
//  SearchRepositoryData.swift
//  GithubClient
//
//  Created by vgogunsky on 16.02.2024.
//

import Foundation

struct SearchRepositoryData: Codable {
    var items: [Repository]
}


struct Repository: Codable {
    let name: String
    let description: String
    let html_url: String
    let owner: Ownner
}

struct Ownner: Codable {
    let avatar_url: String?
}
