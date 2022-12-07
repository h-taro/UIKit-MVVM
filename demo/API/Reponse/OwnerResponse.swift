//
//  OwnerResponse.swift
//  demo
//
//  Created by 平石　太郎 on 2022/12/07.
//

struct OwnerResponse: Codable {
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey{
        case avatarURL = "avatar_url"
    }
}
