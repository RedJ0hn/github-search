//
//  RespsitoryOwner.swift
//  Github search
//
//  Created by Niec, Mateusz on 15/08/2020.
//  Copyright © 2020 Niec, Mateusz. All rights reserved.
//

import Foundation

class RepositoryOwner: Codable {
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case nodeId = "node_id"
        case avatarUrl = "avarat_url"
        case url
        case type
    }
    
    let login: String?
    let id: Int?
    let nodeId: String?
    let avatarUrl: String?
    let url: String?
    let type: String?
    
}
