//
//  NetworkManager.swift
//  Github search
//
//  Created by Niec, Mateusz on 15/08/2020.
//  Copyright © 2020 Niec, Mateusz. All rights reserved.
//

import Foundation

class RequestManager {
    
    static private let apiUrl = "https://api.github.com"
    
    static func searchRepository(name: String, sort: String = "best-match", order: String = "desc", successBlock: @escaping ([Repository])->(), failtureBlock: @escaping (Error)->()) {
        let params = [
            "q": name,
            "sort": sort,
            "order": order
        ]
        let url = apiUrl + "/search/repositories"
        Request.perform(url, method: .get, params: params, successBlock: { data in
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            if let data = data, let repos = (try? decoder.decode(GetRepositoriesResponse.self, from: data)) {
                successBlock(repos.items ?? [])
            } else {
                failtureBlock(NSError(domain: "Parsing error", code: 999, userInfo: nil))
            }
        }) { (error) in
            failtureBlock(error)
        }
    }
    
    static func getReadMe(owner: String, repository: String, successBlock: @escaping (ReadMeData)->(), failtureBlock: @escaping (Error)->()) {
        let url = apiUrl + String(format: "/repos/%@/%@/contents/README.md", owner, repository)
        Request.perform(url, method: .get, successBlock: { (data) in
            if let data = data, let readMeData = (try? JSONDecoder().decode(ReadMeData.self, from: data)) {
                successBlock(readMeData)
            } else {
                failtureBlock(NSError(domain: "Parsing error", code: 999, userInfo: nil))
            }
        }) { (error) in
            failtureBlock(error)
        }
    }
    
}
