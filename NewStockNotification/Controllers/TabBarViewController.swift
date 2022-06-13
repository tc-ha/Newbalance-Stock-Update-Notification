//
//  TabBarController.swift
//  NewStockNotification
//
//  Created by taechan on 2022/06/01.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = MainViewController()
        let vc2 = FavoriteViewController()
        
        vc1.title = "Main"
        vc2.title = "Favorite"
        
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        
        nav1.navigationBar.tintColor = .label
        nav2.navigationBar.tintColor = .label
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart"), tag: 1)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1, nav2], animated: false)
    }
}
