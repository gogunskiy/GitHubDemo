//
//  SearchRepositoryService.swift
//  GithubClient
//
//  Created by vgogunsky on 16.02.2024.
//

import Foundation
import Combine

protocol SearchRepositoryServiceType {
    func searchRepositories(with query: String, completion: @escaping (SearchRepositoryData, Error?) -> Void)
}

final class SearchRepositoryService: SearchRepositoryServiceType {
    private let networkAgent: NetworkAgentProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    init(networkAgent: NetworkAgentProtocol) {
        self.networkAgent = networkAgent
    }

    func searchRepositories(with query: String, completion: @escaping (SearchRepositoryData, Error?) -> Void) {
        networkAgent.fetchData(Request.searchRepository(query)).sink { completion in
            print(completion)
        } receiveValue: {(data: SearchRepositoryData) in
            completion(data, nil)
        }.store(in: &cancellables)
    }
    


}
