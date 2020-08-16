//
//  ReadMeData.swift
//  Github search
//
//  Created by Niec, Mateusz on 15/08/2020.
//  Copyright © 2020 Niec, Mateusz. All rights reserved.
//

import Foundation

class ReadMeData: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case path
        case sha
        case size
        case url
        case htmlUrl = "html_url"
        case gitUrl = "git_url"
        case downloadUrl = "download_url"
        case type
        case content
        case encoding
    }
    
    let name: String?
    let path: String?
    let sha: String?
    let size: Int?
    let url: String?
    let htmlUrl: String?
    let gitUrl: String
    let downloadUrl: String?
    let type: String?
    let content: String?
    let encoding: String?
}
