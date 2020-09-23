//
//  AppDelegate.swift
//  VKApp
//
//  Created by Zelinskaya Anna on 22.09.2020.
//  Copyright © 2020 Zelinskaya Anna. All rights reserved.
//

import UIKit
import VK_ios_sdk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		return true
	}

	
	// MARK: UISceneSession Lifecycle
	
	
	func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
		VKSdk.processOpen(url, fromApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?)
		return true
	}
}

