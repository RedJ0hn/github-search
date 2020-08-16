//
//  SearchRepoViewController.swift
//  Github search
//
//  Created by Niec, Mateusz on 15/08/2020.
//  Copyright © 2020 Niec, Mateusz. All rights reserved.
//

import UIKit

class SearchRepositoryViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    var viewModel = SearchRepositoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SearchResultViewControllerViewController {
            destination.viewModel = SearchResultViewModel(repos: viewModel.getRepos()) 
        }
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        nameTextField.resignFirstResponder()
        viewModel.searchRepo(name: nameTextField.text, successBlock: {
            self.performSegue(withIdentifier: "ShowResults", sender: nil)
        }, failtureBlock: {})
        
    }
    
}

