//
//  SearchRepoViewModel.swift
//  Github search
//
//  Created by Niec, Mateusz on 16/08/2020.
//  Copyright © 2020 Niec, Mateusz. All rights reserved.
//

import Foundation
import SVProgressHUD

class SearchRepositoryViewModel {
    
    var repos: [Repository] = []
    
    func searchRepo(name: String?, successBlock: @escaping () -> (), failtureBlock: @escaping () -> ()) {
        SVProgressHUD.show()
        RequestManager.searchRepository(name: name ?? "", successBlock: { (repos) in
            SVProgressHUD.popActivity()
            self.repos = repos
            successBlock()
        }) { (error) in
            SVProgressHUD.popActivity()
            SVProgressHUD.showError(withStatus: error.localizedDescription)
            SVProgressHUD.dismiss(withDelay: 3)
        }
    }
    
    func getRepos() -> [Repository] {
        return repos
    }
    
}
