//
//  SearchRepoViewController.swift
//  Github search
//
//  Created by Niec, Mateusz on 15/08/2020.
//  Copyright © 2020 Niec, Mateusz. All rights reserved.
//

import UIKit
import SnapKit

class SearchRepositoryViewController: UIViewController {
    
    lazy var mainLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Github repository search"
        label.font = label.font.withSize(24)
        label.textAlignment = .center
        view.addSubview(label)
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = CustomTextField(frame: .zero)
        textField.placeholder = "Repository name"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray2.cgColor
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Search", for: .normal)
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        button.setTitleColor(.systemBlue, for: .normal)
        button.showsTouchWhenHighlighted = true
        return button
    }()
    
    lazy var searchStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, searchButton])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 33
        view.addSubview(stackView)
        return stackView
    }()
    
    var viewModel = SearchRepositoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
    }

    @objc func searchButtonTapped() {
        nameTextField.resignFirstResponder()
        viewModel.searchRepo(name: nameTextField.text, successBlock: {
            let vc = SearchResultViewController()
            vc.viewModel = SearchResultViewModel(repos: self.viewModel.getRepos())
            self.navigationController?.pushViewController(vc, animated: true)
        }, failtureBlock: {})
        
    }
    
    func setConstraints(){
        mainLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(33)
            make.bottom.equalTo(searchStackView.snp.top).offset(-33)
        }
        searchStackView.snp.makeConstraints { (make) in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(22)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-22)
        }
        
    }
    
}

