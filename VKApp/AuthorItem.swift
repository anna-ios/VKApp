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
		id = json["id"].intValue
		image = json["photo_100"].stringValue
		let fullName = json["name"].stringValue
		let nameWithSurname = json["first_name"].stringValue + " " + json["last_name"].stringValue
		name = fullName.isEmpty ? nameWithSurname : fullName
	}
}
