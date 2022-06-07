//
//  SearchResultsViewController.swift
//  NewStockNotification
//
//  Created by taechan on 2022/06/01.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        textLabel.text = "Test"
        textLabel.textColor = .systemBlue
        
        self.view.backgroundColor = .systemBackground
        
    }
}
