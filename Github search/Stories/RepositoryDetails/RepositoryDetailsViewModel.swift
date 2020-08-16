//
//  RepositoryDetailsViewModel.swift
//  Github search
//
//  Created by Niec, Mateusz on 16/08/2020.
//  Copyright © 2020 Niec, Mateusz. All rights reserved.
//

import Foundation
import SVProgressHUD

class RepositoryDetailsViewModel {
    
    var repo: Repository?
    var readMe: ReadMeData?
    
    init(repo: Repository?) {
        self.repo = repo
    }
    
    func loadReadMe(successBlock: @escaping () -> (), failtureBlock: @escaping ()-> ()) {
        SVProgressHUD.show()
        RequestManager.getReadMe(owner: repo?.owner?.login ?? "", repository: repo?.name ?? "", successBlock: { (readme) in
            SVProgressHUD.popActivity()
            self.readMe = readme
            successBlock()
        }) { (error) in
            SVProgressHUD.popActivity()
            failtureBlock()
        }
    }
    
    func loadAvatar(successBlock: @escaping (UIImage) -> (), failtureBlock: @escaping ()-> ()) {
        guard let url = URL(string: repo?.owner?.avatarUrl ?? ""), let data = try? Data(contentsOf: url), let image = UIImage.init(data: data) else {
            failtureBlock()
            return
        }
        successBlock(image)
    }
    
    func getRepoName() -> String {
        return repo?.name ?? ""
    }
    
    func getAuthorLogin() -> String {
        return repo?.owner?.login ?? ""
    }
    
    func getRepoPrivacy() -> String {
        if let isPrivate = repo?.isPrivate {
            return isPrivate ? "Private" : "Public"
        }
        return ""
    }
    
    func getCreationDate() -> String {
        return "Created at: " + (repo?.createdAt?.getString(format: "dd.MM.yyyy") ?? "")
    }
    
    func getUpdateDate() -> String {
        return "Updated at: " + (repo?.updatedAt?.getString(format: "dd.MM.yyyy") ?? "")
    }
    
    func getPushedDate() -> String {
        return "Pushed at: " + (repo?.pushedAt?.getString(format: "dd.MM.yyyy") ?? "")
    }
    
    func getWatchersCount() -> String {
        return "Watchers: \(repo?.watchersCount ?? 0)"
    }
    
    func getForksCount() -> String {
        return "Forks: \(repo?.forksCount ?? 0)"
    }
    
    func getIssuesCount() -> String {
        return "Open issues: \(repo?.openIssuesCount ?? 0)"
    }
    
    func getScore() -> String {
        return "Score: \(repo?.score ?? 0)"
    }
    
    func getDescription() -> String {
        return repo?.description ?? ""
    }
    
    func getHtmlUrl() -> String {
        return readMe?.htmlUrl ?? ""
    }
    
}
