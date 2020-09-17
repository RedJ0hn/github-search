//
//  SearchResultViewModel.swift
//  Github search
//
//  Created by Niec, Mateusz on 16/08/2020.
//  Copyright © 2020 Niec, Mateusz. All rights reserved.
//

import Foundation

class SearchResultViewModel {
    
    var repos: [Repository] = []
    
    init(repos: [Repository]) {
        self.repos = repos
    }
    
    func getReposCount() -> Int {
        return repos.count
    }
    
    func getRepoAt(indexPath: IndexPath) -> Repository {
        return repos[indexPath.row]
    }

}
