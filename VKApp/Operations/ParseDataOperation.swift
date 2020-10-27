//
//  ParseDataOperation.swift
//  VKApp
//
//  Created by Zelinskaya Anna on 15.10.2020.
//  Copyright © 2020 Zelinskaya Anna. All rights reserved.
//

import UIKit
import SwiftyJSON
import VK_ios_sdk

class ParseDataOperation: Operation {
	
	var posts: [PostItem] = []
	
	override func main() {
		guard let getDataOperation = dependencies.first as? GetDataOperation,
			let response = getDataOperation.response,
			let responseJson = response.json
			else { return }
		let json = JSON(responseJson)
		let postItems = NSMutableArray()
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
			postItems.add(post)
		}
		
		posts = postItems.copy() as! [PostItem]
	}

}
