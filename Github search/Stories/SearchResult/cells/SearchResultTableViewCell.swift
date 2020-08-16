//
//  SearchResultTableViewCell.swift
//  Github search
//
//  Created by Niec, Mateusz on 15/08/2020.
//  Copyright © 2020 Niec, Mateusz. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    func configure(with repo: Repository) {
        repositoryNameLabel.text = "Name: " + (repo.name ?? "")
        authorLabel.text = "Author: " + (repo.owner?.login ?? "")
        creationDateLabel.text = "Creatio date: " + (repo.createdAt?.getString(format: "dd.MM.yyyy") ?? "")
        languageLabel.text = "Language: " + (repo.language ?? "")
    }

}
