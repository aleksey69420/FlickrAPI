//
//  AppDelegate.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/17/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		window = UIWindow(frame: UIScreen.main.bounds)
		setRootVC()
		window?.makeKeyAndVisible()
		
		return true
	}
	
	private func setRootVC() {
		window?.rootViewController = TabBarController()
	}
}

