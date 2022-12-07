//
//  GitHubRepositories.swift
//  demo
//
//  Created by 平石　太郎 on 2022/12/07.
//

import ApiClient

struct GitHubRepository: Codable, Identifiable {
    let id: Int
    let fullName: String
    let owner: OwnerResponse
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case owner
        case description
    }
}
