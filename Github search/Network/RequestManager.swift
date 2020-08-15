//
//  NetworkManager.swift
//  Github search
//
//  Created by Niec, Mateusz on 15/08/2020.
//  Copyright © 2020 Niec, Mateusz. All rights reserved.
//

import Foundation
import Alamofire

class RequestManager {
    
    static private let apiUrl = "https://api.github.com"
    
    static func searchRepository(name: String, sort: String = "best-match", order: String = "desc", successBlock: @escaping ([Repository])->(), failtureBlock: @escaping (Error)->()) {
        let params = [
            "q": name,
            "sort": sort,
            "order": order
        ]
        let url = RequestManager.apiUrl + "/search/repositories"
        Request.perform(url, method: .get, params: params, successBlock: { data in
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            guard let data = data, let repos = (try? decoder.decode(GetRepositoriesResponse.self, from: data)) else { return }
            successBlock(repos.items ?? [])
        }) { (error) in
            failtureBlock(error)
        }
    }
    
    static func getReadme(owner: String, repository: String, successBlock: @escaping ([Any])->(), failtureBlock: @escaping (Error)->()) {
        
    }
    
}
