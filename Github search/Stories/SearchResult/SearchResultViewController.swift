//
//  SearchResultViewController.swift
//  Github search
//
//  Created by Niec, Mateusz on 15/08/2020.
//  Copyright © 2020 Niec, Mateusz. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    enum Section {
        case main
    }

    typealias DataSource = UICollectionViewDiffableDataSource<Section, Repository>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Repository>
    
    var viewModel: SearchResultViewModel?
    lazy var dataSource = makeDataSource()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: getCollectionViewLayout())
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        return collectionView
    }()
    
    func setConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        applySnapshot(animating: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.delegate = self
    }
    
    func getCollectionViewLayout() -> UICollectionViewLayout {
        let fullItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1/2)))
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1/2))
        let pairItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)))
        let pairGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: pairItem,
            count: 2)
        let mainGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(3/10)),
            subitems: [fullItem, pairGroup])
        let section = NSCollectionLayoutSection(group: mainGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, repository) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultCell", for: indexPath) as? SearchResultCollectionViewCell
            cell?.configure(with: repository)
            return cell
        }
        return dataSource
    }
    
    func applySnapshot(animating: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel?.repos ?? [])
        dataSource.apply(snapshot, animatingDifferences: animating)
    }

}

extension SearchResultViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let repo = dataSource.itemIdentifier(for: indexPath) else { return }
        let vc = RepositoryDetailsViewController()
        vc.viewModel = RepositoryDetailsViewModel(repo: repo)
        vc.view.backgroundColor = UIColor.systemBackground
        navigationController?.pushViewController(vc, animated: true)
    }
}

