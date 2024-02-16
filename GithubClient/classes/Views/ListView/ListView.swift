//
//  ListView.swift
//  GithubClient
//
//  Created by vgogunsky on 16.02.2024.
//

import SwiftUI

struct ListView: View {
    @StateObject var viewModel: ListViewModel

    var body: some View {
        NavigationStack {
            Text("Searching for \(viewModel.searchText)")
                .navigationTitle("Search for Repo")
            
            List {
                ForEach($viewModel.repositories) { $repo in
                    HStack {
                        AsyncImage(url: repo.imageUrl) { phase in
                                     switch phase {
                                     case .empty:
                                         ProgressView()
                                     case .success(let image):
                                         image.resizable()
                                              .aspectRatio(contentMode: .fit)
                                              .frame(maxWidth: 300, maxHeight: 100)
                                     case .failure:
                                         Image(systemName: "default_image")
                                     @unknown default:
                                         EmptyView()
                                     }
                                 }
                        VStack {
                            Text(repo.name)
                            Text(repo.description)
                        }
                        
                        NavigationLink(destination: DetailsView(url: repo.url)) {}
                    }
                }
            }
        }.onReceive(
            viewModel.$searchText.debounce(for: 1, scheduler: RunLoop.main)
         ) { query in
            viewModel.searchRepositories(with: query)
        }
        .searchable(text: $viewModel.searchText)

    }
}

#Preview {
    ListView(viewModel: ListViewModel(searchService: SearchRepositoryService(networkAgent: NetworkAgent())))
}
