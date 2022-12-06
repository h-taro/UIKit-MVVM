//
//  HomeViewModel.swift
//  demo
//
//  Created by 平石　太郎 on 2022/12/07.
//

import THLogger
import Combine

class HomeViewModel {
    private lazy var apiService: APIService = .init()

    private(set) var githubReposSubject: CurrentValueSubject<[GitHubRepository], Never> = .init([])
    
    func onSearchRepositories(_ query: String) {
        updateGithubRepository(query: query)
    }
}

// MARK: - API
extension HomeViewModel {
    private func updateGithubRepository(query: String) {
        Task {
            do {
                let response = try await apiService.searchGithubRepository(query: query)
                let repositories = response.items
                githubReposSubject.send(repositories)
            } catch {
                THLogger.error(error)
            }
        }
    }
}
