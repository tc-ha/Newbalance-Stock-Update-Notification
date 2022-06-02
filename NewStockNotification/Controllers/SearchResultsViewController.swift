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
        
//        print("asddadasadd\n")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
