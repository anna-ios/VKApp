//
//  PostsTableViewController.swift
//  VKApp
//
//  Created by Zelinskaya Anna on 08.10.2020.
//  Copyright © 2020 Zelinskaya Anna. All rights reserved.
//

import UIKit

private let kCellNibName = "PostTableViewCell"

class PostsTableViewController: UITableViewController {
	
	var posts = [PostItem]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.register(UINib(nibName: kCellNibName, bundle: nil), forCellReuseIdentifier: kCellNibName)
		setPosts()
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 400
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return posts.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: kCellNibName, for: indexPath) as! PostTableViewCell
		cell.viewModel = PostCellViewModel(post: posts[indexPath.row])
		return cell
	}
	
	func setPosts() {
		PostsService().getVKPosts { posts, error in
			if let VKError = error {
				print(VKError)
				return
			}
			guard let vkPosts = posts else { return }
			self.posts = vkPosts
			self.tableView.reloadData()
		}
	}
}

