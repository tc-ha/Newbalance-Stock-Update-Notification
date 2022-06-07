//
//  MainDetailViewController.swift
//  NewStockNotification
//
//  Created by taechan on 2022/06/02.
//

import UIKit

class MainDetailViewController: UIViewController {
    
//    let label: UILabel = {
//        let label = UILabel()
//        label.text = "Test"
//        label.numberOfLines = 0
//        label.textAlignment = .center
//        label.font = .systemFont(ofSize: 18, weight: .regular)
//        return label
//    }()
    
    var textLabel: String = ""
    var imageUrl: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        self.title = "Detail view"
        
//        print(label)
        
//        view.addSubview(label)
//        setupViews()
    }
    
//    func setupViews() {
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
//        label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
//        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        label.heightAnchor.constraint(equalToConstant: 100).isActive = true
//    }

}
