//
//  RepositoryDetailsViewController.swift
//  Github search
//
//  Created by Niec, Mateusz on 15/08/2020.
//  Copyright © 2020 Niec, Mateusz. All rights reserved.
//

import UIKit
import SafariServices

class RepositoryDetailsViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var imageIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoAuthorLabel: UILabel!
    @IBOutlet weak var privateLabel: UILabel!
    
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var updatedAtLabel: UILabel!
    @IBOutlet weak var pushedAtLabel: UILabel!
    @IBOutlet weak var watchersCountLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var issueCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var readmeButton: UIButton!
    
    var viewModel: RepositoryDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundImageView()
        guard let viewModel = viewModel else { return }
        viewModel.loadReadMe(successBlock: {
            self.readmeButton.isHidden = false
        }, failtureBlock: {
            self.readmeButton.isHidden = true
        })
        configureView()
    }
    
    func roundImageView() {
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    }
    
    func configureView() {
        imageIndicator.startAnimating()
        viewModel?.loadAvatar(successBlock: { (image) in
            self.avatarImageView.image = image
            self.imageIndicator.stopAnimating()
        }, failtureBlock: {
            self.imageIndicator.stopAnimating()
        })
        repoNameLabel.text = viewModel?.getRepoName()
        repoAuthorLabel.text = viewModel?.getAuthorLogin()
        privateLabel.text = viewModel?.getRepoPrivacy()
        createdAtLabel.text = viewModel?.getCreationDate()
        updatedAtLabel.text = viewModel?.getUpdateDate()
        pushedAtLabel.text =  viewModel?.getPushedDate()
        watchersCountLabel.text = viewModel?.getWatchersCount()
        forksCountLabel.text = viewModel?.getForksCount()
        issueCountLabel.text = viewModel?.getIssuesCount()
        scoreLabel.text = viewModel?.getScore()
        descriptionLabel.text = viewModel?.getDescription()
    }
    
    @IBAction func readMeButtonTapped(_ sender: Any) {
        if let viewModel = viewModel, let url = URL(string: viewModel.getHtmlUrl()) {
            let vc = SFSafariViewController(url: url)
            vc.modalPresentationStyle = UIModalPresentationStyle.popover
            present(vc, animated: true, completion: nil)
        }
    }
    
    
}
