//
//  GetRepositoriesResponse.swift
//  Github search
//
//  Created by Niec, Mateusz on 15/08/2020.
//  Copyright © 2020 Niec, Mateusz. All rights reserved.
//

import Foundation

class GetRepositoriesResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
    
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [Repository]?
}
