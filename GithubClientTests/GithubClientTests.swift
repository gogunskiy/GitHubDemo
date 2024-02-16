//
//  GithubClientTests.swift
//  GithubClientTests
//
//  Created by vgogunsky on 16.02.2024.
//

import XCTest
@testable import GithubClient

final class MockSearchRepositoryService: SearchRepositoryServiceType {
    func searchRepositories(with query: String, completion: @escaping (GithubClient.SearchRepositoryData, Error?) -> Void) {
        let repo = Repository(name: "test", description: "test", html_url: "http://test.com", owner: Ownner(avatar_url: "http://avatar.url"))
        completion(SearchRepositoryData(items: [repo]), nil)
    }
}

final class GithubClientTests: XCTestCase {
    let viewModel = ListViewModel(searchService: MockSearchRepositoryService())

    func testViewModel() {
        let expectation = expectation(description: "request")
        viewModel.searchRepositories(with: "q")

        _ = viewModel.$repositories.sink { viewModels in
            if !viewModels.isEmpty {
                XCTAssertEqual(viewModels.count, 1)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation])
    }

}
