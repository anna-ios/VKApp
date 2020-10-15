//
//  PostsService.swift
//  VKApp
//
//  Created by Zelinskaya Anna on 15.10.2020.
//  Copyright © 2020 Zelinskaya Anna. All rights reserved.
//

import SwiftyJSON
import VK_ios_sdk

class PostsService: NSObject {
	
	func getVKPosts(completion: ((_ results: [PostItem]?, _ error: Error?) -> Void)? = nil) {
		guard let req = getVKRequest() else { return }
		req.execute(resultBlock: { response in
			let json = JSON(response?.json ?? "")
			let posts = NSMutableArray()
			var authors = NSMutableArray()
			let dispatchGroup = DispatchGroup()
			for item in json["profiles"].arrayValue {
				DispatchQueue.global().async(group: dispatchGroup) {
					authors.add(AuthorItem(json: item))
				}
			}
			for item in json["groups"].arrayValue {
				DispatchQueue.global().async(group: dispatchGroup) {
					authors.add(AuthorItem(json: item))
				}
			}
			dispatchGroup.notify(queue: DispatchQueue.main) {
				for item in json["items"].arrayValue {
					let post = PostItem(json: item)
					for authorItem in authors {
						if let author = authorItem as? AuthorItem {
							if author.id == abs(post.authorId) {
								post.authorName = author.name
								post.authorImage = author.image
								break
							}
						}
					}
					posts.add(post)
				}
				
				completion?(posts.copy() as? [PostItem], nil)
			}
		}) { error in
			if let err = error { print(err) }
			completion?(nil, error)
		}
	}
	
	func getVKRequest() -> VKRequest? {
		guard VKSdk.isLoggedIn(),
			  let accessToken = VKSdk.accessToken().accessToken else {
				print("Авторизация не пройдена")
				return nil
		}
		let params = ["filters": "post,photo",
					  "access_token": accessToken,
					  "count": 10] as [String : Any]
		return VKRequest(method: "newsfeed.get", parameters: params)
	}
}
