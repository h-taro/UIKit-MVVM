//
//  SearchRepositories.swift
//  demo
//
//  Created by 平石　太郎 on 2022/12/07.
//

import ApiClient

struct SearchRepositoriesRequest: Requestable {
    private let query: String
    
    init(query: String) {
        self.query = query
    }
    
    var baseURL: String {
        "https://api.github.com"
    }
    
    var path: String {
        "/search/repositories"
    }
    
    var method: HttpMethod {
        .get
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var parameters: [String : Any]? {
        ["q": query]
    }
}
