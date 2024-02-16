//
//  ListViewModel.swift
//  GithubClient
//
//  Created by vgogunsky on 16.02.2024.
//

import Foundation
import Combine

struct RepositoryViewModel: Identifiable {
    var id = UUID()
    let name: String
    let description: String
    let url: URL
    let imageUrl: URL?
    
    init(dataModel: Repository) {
        self.name = dataModel.name
        self.description = dataModel.description
        self.url = URL(string: dataModel.html_url) ?? URL(string: "")!
        
        if let avatarUrl = dataModel.owner.avatar_url {
            self.imageUrl = URL(string: avatarUrl)
        } else {
            self.imageUrl = nil
        }
    }
}

final class ListViewModel: ObservableObject {
    let searchService: SearchRepositoryServiceType
    
    @Published var searchText = ""
    @Published var repositories: [RepositoryViewModel] = []

    init(searchService: SearchRepositoryServiceType) {
        self.searchService = searchService
    }
    
    func searchRepositories(with query: String) {
        guard !query.isEmpty else { return }
        searchService.searchRepositories(with: query) { [weak self] data, error in
            self?.repositories = data.items.map { RepositoryViewModel(dataModel: $0) }
        }
    }
}
