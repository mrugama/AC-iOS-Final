//
//  TabBarController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let feedNav = UINavigationController(rootViewController: FeedVC())
        let uploadNav = UINavigationController(rootViewController: UploadVC())
        
        feedNav.tabBarItem = UITabBarItem(title: "Feed", image: UIImage.init(named: "AppIcon"), tag: 0)
        uploadNav.tabBarItem = UITabBarItem(title: "Upload", image: UIImage.init(named: "upload"), tag: 1)
        let tabList = [feedNav, uploadNav]
        viewControllers = tabList
    }

}
