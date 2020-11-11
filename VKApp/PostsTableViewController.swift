//
//  PostsTableViewController.swift
//  VKApp
//
//  Created by Zelinskaya Anna on 08.10.2020.
//  Copyright © 2020 Zelinskaya Anna. All rights reserved.
//

import UIKit

private let kCellNibName = "PostTableViewCell"

class PostsTableViewController: UITableViewController, PostTableViewCellDelegate {
	
	var posts = [PostItem]()
	var nextFrom: String = ""
	var expandedIndexSet : IndexSet = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.register(UINib(nibName: kCellNibName, bundle: nil), forCellReuseIdentifier: kCellNibName)
		tableView.prefetchDataSource = self
		setupRefreshControl()
	}
	
	fileprivate func setupRefreshControl() {
		refreshControl = UIRefreshControl()
		refreshControl?.attributedTitle = NSAttributedString(string: "Загрузка")
		refreshControl?.addTarget(self, action: #selector(refreshPosts), for: .valueChanged)
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		guard expandedIndexSet.contains(indexPath.row) else { return 400 }
		return UITableView.automaticDimension
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return posts.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: kCellNibName, for: indexPath) as! PostTableViewCell
		
		cell.viewModel = PostCellViewModel(post: posts[indexPath.row])
		cell.delegate = self
		let expanded = expandedIndexSet.contains(indexPath.row)
		cell.setShowMoreButtonTitle(expanded : expanded)
		cell.setPostTextLabelHeight(expanded : expanded)
		cell.hideShowMoreButton(expanded: expanded)
		
		tableView.reloadRows(at: [indexPath], with: .automatic)

		return cell
	}
	
	@objc func refreshPosts() {
		self.refreshControl?.beginRefreshing()
		loadPosts()
	}
	
	func reloadCell(cell: PostTableViewCell) {
		guard let indexPath = tableView.indexPath(for: cell) else { return }
		if expandedIndexSet.contains(indexPath.row) {
			expandedIndexSet.remove(indexPath.row)
		}
		else {
			expandedIndexSet.insert(indexPath.row)
		}
		DispatchQueue.main.async { [weak self] in
			self?.tableView.reloadRows(at: [indexPath], with: .automatic)
		}
	}
	
	func loadPosts() {
		PostsService().getPartVKPosts(
			startFrom: self.nextFrom,
			completion: { [weak self] posts, nextFrom, error in
				guard let self = self else {
					return
				}
				if let VKError = error {
					print(VKError)
					return
				}
				
				guard let vkPosts = posts else { return }
				self.posts = self.posts + vkPosts
				self.nextFrom = nextFrom ?? ""
				self.tableView.reloadData()
				self.refreshControl?.endRefreshing()
			}
		)
	}
}

extension PostsTableViewController: UITableViewDataSourcePrefetching {
	func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
		guard indexPaths.contains(where: isLoadingCell(for:)) else { return }
		
		loadPosts()
	}
	
	func isLoadingCell(for indexPath: IndexPath) -> Bool {
		return indexPath.row == (posts.count - 3)
	}
}

