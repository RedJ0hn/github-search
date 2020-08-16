//
//  SearchResultViewControllerViewController.swift
//  Github search
//
//  Created by Niec, Mateusz on 15/08/2020.
//  Copyright © 2020 Niec, Mateusz. All rights reserved.
//

import UIKit

class SearchResultViewControllerViewController: UIViewController {

    var viewModel: SearchResultViewModel?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RepositoryDetailsViewController {
            destination.viewModel = RepositoryDetailsViewModel(repo: viewModel?.getSelectedRepo())
        }
    }

}

extension SearchResultViewControllerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.getReposCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let viewModel = viewModel, let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell") as? SearchResultTableViewCell {
            cell.configure(with: viewModel.getRepoAt(indexPath: indexPath))
            return cell
        }
        return UITableViewCell()
    }
    
}

extension SearchResultViewControllerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.selectRepoAt(indexPath: indexPath)
        performSegue(withIdentifier: "ShowDetails", sender: nil)
    }
    
}
