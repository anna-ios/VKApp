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
	let likes: String
	let comments: String
	let reposts: String
	let authorId: Int
	var authorName = ""
	var authorImage = ""
	var date = ""
	
	init(json: JSON) {
		self.text = json["text"].stringValue
		self.postImage = json["attachments"][0]["photo"]["photo_807"].stringValue
		self.likes = json["likes"]["count"].stringValue
		self.comments = json["comments"]["count"].stringValue
		self.reposts = json["reposts"]["count"].stringValue
		self.authorId = json["source_id"].intValue
		self.date = self.dateFromDoubleDate(doubleDate: json["date"].doubleValue)
	}
	
	func dateFromDoubleDate(doubleDate: Double) -> String {
		let df = DateFormatter()
		df.dateFormat = "yyyy-MM-dd hh:mm:ss"
		let strDate = df.string(from: Date(timeIntervalSince1970: doubleDate))
		return strDate
	}
}
