//
//  PostCellViewModel.swift
//  VKApp
//
//  Created by Zelinskaya Anna on 15.10.2020.
//  Copyright © 2020 Zelinskaya Anna. All rights reserved.
//

import Foundation

class PostCellViewModel {
	let date: String
	let text: String
	let postImage: String
	let likes: String
	let comments: String
	let reposts: String
	let authorName: String
	let authorImage: String
	
	init(post: PostItem) {
		self.date = post.date
		self.text = post.text
		self.postImage = post.postImage
		self.likes = post.likes
		self.comments = post.comments
		self.reposts = post.reposts
		self.authorName = post.authorName
		self.authorImage = post.authorImage
	}

}
