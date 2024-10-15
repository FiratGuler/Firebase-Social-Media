//
//  CustomTabBar.swift
//  FirebaseTask
//
//  Created by Fırat Güler on 7.10.2024.
//

import UIKit

class CustomTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }

    func setupTabBar() {
        
        tabBar.tintColor = .white
        tabBar.backgroundColor = .black
        tabBar.unselectedItemTintColor = .gray
        
        let homeVC = HomeVC()
        let profileVC = ProfileVC()
        let uploadPhotoVC = UploadPhotoVC()
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        uploadPhotoVC.tabBarItem = UITabBarItem(title: "Add", image: UIImage(systemName: "plus"), tag: 1)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)
        
        let controllers = [homeVC,uploadPhotoVC,profileVC]
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0) }
    }

    

}
