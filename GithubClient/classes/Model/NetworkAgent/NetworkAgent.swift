//
//  NetworkAgent.swift
//  GithubClient
//
//  Created by vgogunsky on 16.02.2024.
//

import Foundation
import Combine

protocol NetworkRequest {
    var requestURL: URL? { get }
}

enum NetworkError: Error {
    case malformedURL
}

protocol NetworkAgentProtocol {
    func fetchData<Data: Decodable>(_ request: NetworkRequest) -> AnyPublisher <Data, Error>
}


enum Request: NetworkRequest {
    case searchRepository(String)
    
    var requestURL: URL? {
        switch self {
        case .searchRepository(let query):
            return URL(string: "https://api.github.com/search/repositories?q=\(query)")
        }
    }
}

class NetworkAgent: NetworkAgentProtocol {
    func fetchData<Data>(_ request: NetworkRequest) -> AnyPublisher<Data, Error> where Data : Decodable {
        guard let url = request.requestURL else {
            return Fail(error: NetworkError.malformedURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.setValue("2022-11-28", forHTTPHeaderField: "X-GitHub-Api-Version")
        request.setValue("Bearer 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", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Data.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

