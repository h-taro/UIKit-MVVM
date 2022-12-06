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
    private(set) var homeViewStateSubject: CurrentValueSubject<HomeViewState, Never> = .init(.default)
    
    func onSearchRepositories(_ query: String) {
        updateGithubRepository(query: query)
    }
}

// MARK: - API
extension HomeViewModel {
    private func updateGithubRepository(query: String) {
        Task {
            homeViewStateSubject.send(.loading)

            do {
                let response = try await apiService.searchGithubRepository(query: query)
                let repositories = response.items
                
                homeViewStateSubject.send(.loaded)
                githubReposSubject.send(repositories)
            } catch {
                THLogger.error(error)
                homeViewStateSubject.send(.loaded)
            }
        }
    }
}
