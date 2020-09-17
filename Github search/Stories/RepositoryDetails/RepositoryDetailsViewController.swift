//
//  RepositoryDetailsViewController.swift
//  Github search
//
//  Created by Niec, Mateusz on 15/08/2020.
//  Copyright © 2020 Niec, Mateusz. All rights reserved.
//

import UIKit
import SafariServices
import SnapKit

class RepositoryDetailsViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        view.addSubview(scrollView)
        return scrollView
    }()
    
    lazy var scrolableView: UIView = {
        let view = UIView(frame: .zero)
        self.scrollView.addSubview(view)
        return view
    }()
    
    lazy var authorHorizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [avatarImageView, authorLabelsStackView])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        self.scrolableView.addSubview(stackView)
        return stackView
    }()
    
    lazy var authorLabelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [repoNameLabel, repoAuthorLabel, privateLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 9
        return stackView
    }()
    
    lazy var repoDetailsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [createdAtLabel, updatedAtLabel, pushedAtLabel, pushedAtLabel, watchersCountLabel, forksCountLabel, issueCountLabel, scoreLabel, descriptionLabel, readmeButton])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        self.scrolableView.addSubview(stackView)
        return stackView
    }()
    
    lazy var lineView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.systemGray2
        self.scrolableView.addSubview(view)
        return view
    }()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.image = UIImage(systemName: "person.circle")
        return imageView
    }()
    
    lazy var imageIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: .zero)
        indicator.style = .medium
        indicator.hidesWhenStopped = true
        self.avatarImageView.addSubview(indicator)
        return indicator
    }()
    
    lazy var repoNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    lazy var repoAuthorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    lazy var privateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    lazy var createdAtLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    lazy var updatedAtLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    lazy var pushedAtLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    lazy var watchersCountLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    lazy var forksCountLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    lazy var issueCountLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var readmeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.setTitle("Show README", for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(readMeButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    var viewModel: RepositoryDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = viewModel else { return }
        viewModel.loadReadMe(successBlock: {
            self.readmeButton.isHidden = false
        }, failtureBlock: {
            self.readmeButton.isHidden = true
        })
        setConstaraints()
        configureView()
    }
    
    func setConstaraints() {
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrolableView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView.snp.edges)
            make.width.equalToSuperview()
        }
        
        imageIndicator.snp.makeConstraints { (make) in
            make.center.equalTo(avatarImageView.snp.center)
        }
        
        avatarImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
        }
        
        authorHorizontalStackView.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(lineView.snp.top).offset(-10)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(repoDetailsStackView.snp.top).offset(-10)
        }
        
        repoDetailsStackView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.bottom.equalToSuperview().offset(-20)
        }
        
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
