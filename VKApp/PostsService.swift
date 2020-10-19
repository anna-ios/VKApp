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
		guard VKSdk.isLoggedIn(),
			  let accessToken = VKSdk.accessToken().accessToken else {
				print("Авторизация не пройдена")
				return
		}
		let params = ["filters": "post,photo",
					  "access_token": accessToken,
					  "count": 10] as [String : Any]
		let req = VKRequest(method: "newsfeed.get", parameters: params)
		req?.execute(resultBlock: { response in
			let json = JSON(response?.json ?? "")
			let posts = NSMutableArray()
			let authors = NSMutableArray()
			
			for item in json["profiles"].arrayValue {
				authors.add(AuthorItem(json: item))
			}
			for item in json["groups"].arrayValue {
				authors.add(AuthorItem(json: item))
			}
			
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
		}, errorBlock: { error in
			if let err = error { print(err) }
			completion?(nil, error)
		})
	}
}
