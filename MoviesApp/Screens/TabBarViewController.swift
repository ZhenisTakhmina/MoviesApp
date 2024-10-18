//
//  TabBarViewController.swift
//  MoviesApp
//
//  Created by Tami on 17.10.2024.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
}

private extension TabBarViewController {
    
    func setupViewControllers(){
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor = UIColor(hex: "242A32")
        tabBarAppearance.shadowImage = UIImage(named: "tab_shadow")
        tabBar.isTranslucent = false
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .gray
        tabBar.standardAppearance = tabBarAppearance
        
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBarAppearance
        }
        
        viewControllers = [
            getTabController(rootViewController: HomeViewController(), title: "Home", image: UIImage(systemName: "house")!),
            getTabController(rootViewController: SearchViewController(), title: "Search", image: UIImage(systemName: "magnifyingglass")!),
            getTabController(rootViewController: FavouritesViewController(), title: "Favourites", image: UIImage(systemName: "heart")!)
        ]
        
    }
    
    func getTabController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
