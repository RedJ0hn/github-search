//
//  Repository.swift
//  Github search
//
//  Created by Niec, Mateusz on 15/08/2020.
//  Copyright © 2020 Niec, Mateusz. All rights reserved.
//

import Foundation

class Repository: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case nodeId = "node_id"
        case name
        case fullName = "full_name"
        case owner
        case isPrivate = "private"
        case htmlUrl = "html_url"
        case description
        case fork
        case url
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case homepage
        case size
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case masterBranch = "master_branch"
        case defaultBranch = "default_branch"
        case score
    }
    
    let id: Int?
    let nodeId: String?
    let name: String?
    let fullName: String?
    let owner: RepositoryOwner?
    let isPrivate: Bool
    let htmlUrl: String?
    let description: String?
    let fork: Bool?
    let url: String?
    let createdAt: Date?
    let updatedAt: Date?
    let pushedAt: Date?
    let homepage: String?
    let size: Int?
    let stargazersCount: Int?
    let watchersCount: Int?
    let language: String?
    let forksCount: Int?
    let openIssuesCount: Int?
    let masterBranch: String?
    let defaultBranch: String?
    let score: Double?

}
