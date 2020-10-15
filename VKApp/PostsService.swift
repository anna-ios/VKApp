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
		if VKSdk.isLoggedIn() {
			let params = ["filters": "post,photo",
						  "access_token": VKSdk.accessToken()?.accessToken ?? "",
						  "count": 10] as [String : Any]
			let req = VKRequest.init(method: "newsfeed.get", parameters: params)
			req?.execute(resultBlock: { response in
				let json = JSON(response?.json ?? "")
				let posts = NSMutableArray.init()
				let authors = NSMutableArray.init()
				
				for item in json["profiles"].arrayValue {
					authors.add(AuthorItem.init(json: item))
				}
				for item in json["groups"].arrayValue {
					authors.add(AuthorItem.init(json: item))
				}
				
				for item in json["items"].arrayValue {
					let post = PostItem.init(json: item)
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
				print(error!)
				completion?(nil, error)
			})
		}
	}
}
