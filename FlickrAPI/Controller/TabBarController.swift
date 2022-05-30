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
		
		viewControllers = [createSearchVC(), createSavedPhotosVC()]
	}
	
	
	func createSearchVC() -> UINavigationController {
		let mainVC = MainVC()
		mainVC.title = "Search Screen"
		mainVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
		return UINavigationController(rootViewController: mainVC)
		
	}
	
	
	func createSavedPhotosVC() -> UINavigationController {
		let savedPhotosVC = SavedPhotosVC()
		savedPhotosVC.title = "Saved Photos"
		savedPhotosVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
		
		return UINavigationController(rootViewController: savedPhotosVC)
		
	}
}
