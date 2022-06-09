//
//  FavoriteViewController.swift
//  NewStockNotification
//
//  Created by taechan on 2022/06/01.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate {
    
    var products: Products!
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: MainViewController.generateLayout())
    
    
    enum Section: CaseIterable {
        case first
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Shoes>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
        configureCollectionView()
        configureDatasource()
        fetchData()
    }
    
    func configureSearchController() {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.showsScopeBar = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchResultsUpdater = self // ✅
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
    }
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
    }
    
    func configureDatasource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath,
            model in
            
            let type = Section.allCases[indexPath.section]
            switch type {
            case .first:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CollectionViewCell.identifier,
                    for: indexPath) as? CollectionViewCell else { fatalError("Could not create new cell") }
                print(indexPath.row)
                let url = URL(string: model.image)
                let name = model.name
                cell.configure(with: url!, with: name)
                return cell
            }
        })
    }
    
    func fetchData() {
        APICaller.shared.getCurrentShoesStock { [weak self] result in
            switch result {
            case .success(let model):
                self?.products = model
                DispatchQueue.main.async {
                    self?.updateDatasource(with: nil)
                }
            case .failure(let error):
                print("loading failed...", error)
            }
        }
    }
    
    func updateDatasource(with filter: String?) {
        let filtered = self.products.products.filter { $0.name.lowercased().hasPrefix(filter ?? "") }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Shoes>()
        snapshot.appendSections([.first])
        snapshot.appendItems(filtered)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    static func generateLayout() -> UICollectionViewCompositionalLayout {
        // Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        
        // Group
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(2/7)
            ),
            subitem: item,
            count: 2
        )
        // Section
        let secion = NSCollectionLayoutSection(
            group: group)
        
        // Return
        return UICollectionViewCompositionalLayout(section: secion)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = MainDetailViewController()
        let row = self.products.products[indexPath.row]
        let width = row.width
        let imageUrl = row.image
        let name = row.name
        detailVC.configure(withUrl: imageUrl, withName: name)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // print(searchController.searchBar.text)
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        DispatchQueue.main.async {
            self.updateDatasource(with: text)
        }
    }
}

