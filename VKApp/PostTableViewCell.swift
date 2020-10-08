//
//  PostTableViewCell.swift
//  VKApp
//
//  Created by Zelinskaya Anna on 08.10.2020.
//  Copyright © 2020 Zelinskaya Anna. All rights reserved.
//

import UIKit

private let kHeaderViewHeight = 50.0
private let kFooterViewHeight = 40.0
private let kInsets = 10.0

class PostTableViewCell: UITableViewCell {
	
	@IBOutlet weak var headerView: UIView! {
		didSet { headerView.translatesAutoresizingMaskIntoConstraints = false }
	}
	
	@IBOutlet weak var postContentView: UIView! {
		didSet { postContentView.translatesAutoresizingMaskIntoConstraints = false }
	}
	
	@IBOutlet weak var footerView: UIView! {
		didSet { footerView.translatesAutoresizingMaskIntoConstraints = false }
	}
		
	override func layoutSubviews() {
		super.layoutSubviews()
		
		setHeaderViewFrame()
		setPostContentViewViewFrame()
		setFooterViewViewFrame()
	}
	
	func setHeaderViewFrame() {
		let x = kInsets
		let y = 0.0
		let width = Double(bounds.width) - kInsets - kInsets
		let height = kHeaderViewHeight
		let origin = CGPoint(x: ceil(x), y: ceil(y))
		let size = CGSize(width: ceil(width), height: ceil(height))
		
		headerView.frame = CGRect(origin: origin, size: size)
	}
	
	func setPostContentViewViewFrame() {
		let x = kInsets
		let y = kHeaderViewHeight
		let width = Double(bounds.width) - kInsets - kInsets
		let height = Double(bounds.height) - kHeaderViewHeight - kFooterViewHeight
		let origin = CGPoint(x: ceil(x), y: ceil(y))
		let size = CGSize(width: ceil(width), height: ceil(height))
		
		postContentView.frame = CGRect(origin: origin, size: size)
	}
	
	func setFooterViewViewFrame() {
		let x = kInsets
		let y = Double(bounds.height) - kFooterViewHeight
		let width = Double(bounds.width) - kInsets - kInsets
		let height = kFooterViewHeight
		let origin = CGPoint(x: ceil(x), y: ceil(y))
		let size = CGSize(width: ceil(width), height: ceil(height))
		
		footerView.frame = CGRect(origin: origin, size: size)
	}
}
