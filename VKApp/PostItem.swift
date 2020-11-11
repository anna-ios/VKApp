//
//  PostItem.swift
//  VKApp
//
//  Created by Zelinskaya Anna on 15.10.2020.
//  Copyright © 2020 Zelinskaya Anna. All rights reserved.
//

import SwiftyJSON

class PostItem {
	let text: String
	let postImage: String
	let postImageWidth: Float
	let postImageHeight: Float
	let likes: String
	let comments: String
	let reposts: String
	let authorId: Int
	var authorName = ""
	var authorImage = ""
	var date = ""
	
	init(json: JSON) {
		text = json["text"].stringValue
		postImage = json["attachments"][0]["photo"]["photo_807"].stringValue
		postImageWidth = json["attachments"][0]["photo"]["width"].floatValue
		postImageHeight = json["attachments"][0]["photo"]["height"].floatValue
		likes = json["likes"]["count"].stringValue
		comments = json["comments"]["count"].stringValue
		reposts = json["reposts"]["count"].stringValue
		authorId = json["source_id"].intValue
		date = json["date"].doubleValue.dateFromDouble()
	}
}
