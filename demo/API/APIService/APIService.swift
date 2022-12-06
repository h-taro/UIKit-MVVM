//
//  APIService.swift
//  demo
//
//  Created by 平石　太郎 on 2022/12/07.
//

import THApiClient

class APIService {
    private let apiClient: THApiClient = .init(waitTime: 10)
    
    func searchGithubRepository(query: String) async throws -> SearchGithubRepositoriesResponse {
        let request = SearchRepositoriesRequest(query: query)
        return try await apiClient.call(request)
    }
}
