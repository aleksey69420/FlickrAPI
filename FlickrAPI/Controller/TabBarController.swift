//
//  TabBarController.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/27/22.
//

import UIKit

class TabBarController: UITabBarController {
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewControllers = [createSearchVC()]
	}
	
	
	func createSearchVC() -> UINavigationController {
		let mainVC = MainVC()
		mainVC.title = "Search Screen"
		mainVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
		
		return UINavigationController(rootViewController: mainVC)
		
	}
}
