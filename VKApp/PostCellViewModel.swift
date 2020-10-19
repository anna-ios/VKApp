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
		date = post.date
		text = post.text
		postImage = post.postImage
		likes = post.likes
		comments = post.comments
		reposts = post.reposts
		authorName = post.authorName
		authorImage = post.authorImage
	}
}
