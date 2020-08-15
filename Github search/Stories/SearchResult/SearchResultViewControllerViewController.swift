//
//  SearchResultViewControllerViewController.swift
//  Github search
//
//  Created by Niec, Mateusz on 15/08/2020.
//  Copyright © 2020 Niec, Mateusz. All rights reserved.
//

import UIKit

class SearchResultViewControllerViewController: UIViewController {

    var respos: [Repository] = []
    var selectedRepo: Repository?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RepositoryDetailsViewController {
            destination.repo = selectedRepo
        }
    }

}

extension SearchResultViewControllerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return respos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell") as? SearchResultTableViewCell {
            cell.configure(with: respos[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
}

extension SearchResultViewControllerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedRepo = respos[indexPath.row]
        performSegue(withIdentifier: "ShowDetails", sender: nil)
    }
    
}
