//
//  APIService.swift
//  demo
//
//  Created by 平石　太郎 on 2022/12/07.
//

import ApiClient
import Foundation

class APIService {
    private let apiClient: ApiClient = .init(waitTime: 10)
    
    func searchGithubRepository(query: String) async throws -> SearchGithubRepositoriesResponse {
        let request = SearchRepositoriesRequest(query: query)
        return try await apiClient.call(request)
    }
    
    func getAvatarData(avatarURL: URL) async throws -> Data {
        return try await apiClient.getImageData(url: avatarURL)
    }
}
