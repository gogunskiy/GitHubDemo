//
//  GithubClientApp.swift
//  GithubClient
//
//  Created by vgogunsky on 16.02.2024.
//

import SwiftUI

@main
struct GithubClientApp: App {
    var body: some Scene {
        WindowGroup {
            ListView(viewModel: ListViewModel(searchService: SearchRepositoryService(networkAgent: NetworkAgent())))
        }
    }
}
