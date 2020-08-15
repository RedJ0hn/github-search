//
//  SearchRepoViewController.swift
//  Github search
//
//  Created by Niec, Mateusz on 15/08/2020.
//  Copyright © 2020 Niec, Mateusz. All rights reserved.
//

import UIKit
import SVProgressHUD

class SearchRepoViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    var repos: [Repository] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SearchResultViewControllerViewController {
            destination.respos = repos
        }
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        nameTextField.resignFirstResponder()
        SVProgressHUD.show()
        RequestManager.searchRepository(name: nameTextField.text ?? "", successBlock: { (repos) in
            SVProgressHUD.popActivity()
            self.repos = repos
            self.performSegue(withIdentifier: "ShowResults", sender: nil)
        }) { (error) in
            SVProgressHUD.popActivity()
            SVProgressHUD.showError(withStatus: error.localizedDescription)
            SVProgressHUD.dismiss(withDelay: 3)
        }
    }
    
}

