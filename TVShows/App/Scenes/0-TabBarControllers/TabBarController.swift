//
//  TabBarController.swift
//  TVShows
//
//  Created by Diggo Silva on 01/04/25.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.3215686275, green: 0.5607843137, blue: 0.537254902, alpha: 1)
        UITabBar.appearance().isTranslucent = false
        viewControllers = [createFeedNavigationController(), createFavoritesNavigationController()]
    }
    
    private func createFeedNavigationController() -> UINavigationController {
        let feedVC = FeedViewController()
        feedVC.tabBarItem = UITabBarItem(title: "TV Shows", image: SFSymbols.popcorn, selectedImage: SFSymbols.popcornFill)
        return UINavigationController(rootViewController: feedVC)
    }
    
    private func createFavoritesNavigationController() -> UINavigationController {
        let favoritesVC = FavoritesViewController()
        favoritesVC.tabBarItem = UITabBarItem(title: "Favoritos", image: SFSymbols.star, selectedImage: SFSymbols.starFill)
        return UINavigationController(rootViewController: favoritesVC)
    }
}
