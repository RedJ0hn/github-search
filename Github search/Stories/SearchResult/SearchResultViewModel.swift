//
//  SearchResultViewModel.swift
//  Github search
//
//  Created by Niec, Mateusz on 16/08/2020.
//  Copyright © 2020 Niec, Mateusz. All rights reserved.
//

import Foundation

class SearchResultViewModel {
    
    var respos: [Repository] = []
    var selectedRepo: Repository?
    
    init(repos: [Repository]) {
        self.respos = repos
    }
    
    func getReposCount() -> Int {
        return respos.count
    }
    
    func selectRepoAt(indexPath: IndexPath) {
        selectedRepo = respos[indexPath.row]
    }
    
    func getRepoAt(indexPath: IndexPath) -> Repository {
        return respos[indexPath.row]
    }
    
    func getSelectedRepo() -> Repository? {
        return selectedRepo
    }
}
