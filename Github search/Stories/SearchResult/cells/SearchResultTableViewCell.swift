//
//  SearchResultTableViewCell.swift
//  Github search
//
//  Created by Niec, Mateusz on 15/08/2020.
//  Copyright © 2020 Niec, Mateusz. All rights reserved.
//

import UIKit

class SearchResultCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String = "SearchResultCell"
    
    lazy var repositoryNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        return label
    }()
    
    lazy var creationDateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        return label
    }()
    
    lazy var languageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [repositoryNameLabel, authorLabel, creationDateLabel, languageLabel])
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.axis = .vertical
        contentView.addSubview(stackView)
        return stackView
    }()
    
    func setConstraints() {
        stackView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(11)
            make.bottom.equalToSuperview().offset(-11)
        }
    }
    
    func configure(with repo: Repository) {
        repositoryNameLabel.text = "Name: " + (repo.name ?? "")
        authorLabel.text = "Author: " + (repo.owner?.login ?? "")
        creationDateLabel.text = "Creatio date: " + (repo.createdAt?.getString(format: "dd.MM.yyyy") ?? "")
        languageLabel.text = "Language: " + (repo.language ?? "")
        setConstraints()
    }
    
}
