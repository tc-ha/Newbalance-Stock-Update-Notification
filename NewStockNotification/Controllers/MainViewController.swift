//
//  ViewController.swift
//  NewStockNotification
//
//  Created by taechan on 2022/06/01.
//

import UIKit

class MainViewController: UIViewController {
    
    private var tableView: UITableView! // 이게 왜 꼭 ! 이어야 할까?
    
    var data: [String] = ["Tom", "Jim", "Carry", "John", "Michelle", "Obama", "Barack", "Donald", "Trump", "Biden", "Joe"]
    var filteredData: [String] = []
    
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
        configureTableView()
        tableView.register(TableViewCell.classForCoder(), forCellReuseIdentifier: TableViewCell.cellIdentifier)
    }
    
    func configureSearchController() {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.scopeButtonTitles = [
            "All", "Birthdays", "Weddings",
        ]
        searchController.searchBar.showsScopeBar = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchResultsUpdater = self // ✅
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
    }
    
    func configureTableView() {
        tableView = UITableView()
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.register(TableViewCell.classForCoder(), forCellReuseIdentifier: TableViewCell.cellIdentifier)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

// MARK: - Delegate, DataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isFiltering ? self.filteredData.count : self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellIdentifier, for: indexPath) as! TableViewCell
        
        if self.isFiltering {
            cell.memberNameLabel.text = filteredData[indexPath.row]
        } else {
            cell.memberNameLabel.text = data[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(data[indexPath.row])
        let detailVC = MainDetailViewController()
        navigationController?.pushViewController(detailVC, animated: true)
        // let navVC = UINavigationController(rootViewController: detailVC)
        // navVC.modalPresentationStyle = .fullScreen
        // self.present(navVC, animated: false)
        
    }
}

// MARK: - Search Result Updating

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        // dump(searchController.searchBar.text)
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        self.filteredData = data.filter({ each in
            return each.lowercased().contains(text) // $0.localizedCaseInsensitiveContains(text) or $0.lowercased().hasPrefix(text)
        })
        
        // dump(self.filteredData)
        self.tableView.reloadData()
    }
    
}
