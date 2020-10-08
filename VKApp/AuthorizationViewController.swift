//
//  AuthorizationViewController.swift
//  VKApp
//
//  Created by Zelinskaya Anna on 22.09.2020.
//  Copyright © 2020 Zelinskaya Anna. All rights reserved.
//

import UIKit
import VK_ios_sdk

class AuthorizationViewController: UIViewController, VKSdkUIDelegate, VKSdkDelegate {
	let permissions = NSArray(objects: "friends", "photos", "wall", "groups", "email", "offline") as [AnyObject]
	
	@IBAction func authorization(_ sender: Any) {
		VKSdk.authorize(self.permissions as [AnyObject])
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		VKSdk.initialize(withAppId:"7605648").register(self)
				
		guard let instance = VKSdk.instance() else {
			return
		}
		instance.uiDelegate = self
		
		VKSdk.wakeUpSession(self.permissions) { state, error in
			if let error = error {
				print(error)
				return
			}
			
			switch state {
				case .initialized:
					print("Начинаем авторизацию")
				case .authorized:
					print("Авторизация уже пройдена")
					self.showPostsViewController()
				default: return
			}
		}
	}
		
	func vkSdkShouldPresent(_ controller: UIViewController!) {
		self.navigationController?.topViewController?.present(controller, animated: true, completion: nil)
	}
	
	func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
		let vc = VKCaptchaViewController.captchaControllerWithError(captchaError)
		vc?.present(in: self.navigationController?.topViewController)
	}
	
	func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
		guard let error = result.error else {
			print("Авторизация прошла успешно")
			self.showPostsViewController()
			return
		}
		print(error)
	}
	
	func vkSdkUserAuthorizationFailed() {
		self.navigationController?.popToRootViewController(animated: true)
	}
	
	private func showPostsViewController() {
		let postsViewController = PostsTableViewController()
		postsViewController.modalPresentationStyle = .custom
		self.navigationController?.topViewController?.present(postsViewController, animated: true, completion: nil)
	}
}

