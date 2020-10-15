//
//  AuthorItem.swift
//  VKApp
//
//  Created by Zelinskaya Anna on 15.10.2020.
//  Copyright © 2020 Zelinskaya Anna. All rights reserved.
//

import SwiftyJSON

class AuthorItem {
	let id: Int
	let image: String
	let name: String
	
	init(json: JSON) {
		self.id = json["id"].intValue
		self.image = json["photo_100"].stringValue
		self.name = !json["name"].stringValue.isEmpty ? json["name"].stringValue : json["first_name"].stringValue + " " + json["last_name"].stringValue
	}
}
