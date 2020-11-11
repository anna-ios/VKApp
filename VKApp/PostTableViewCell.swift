//
//  PostTableViewCell.swift
//  VKApp
//
//  Created by Zelinskaya Anna on 08.10.2020.
//  Copyright © 2020 Zelinskaya Anna. All rights reserved.
//

import UIKit

protocol PostTableViewCellDelegate {
	func reloadCell(cell: PostTableViewCell)
}

private let kHeaderViewHeight = 50.0
private let kFooterViewHeight = 40.0
private let kInsets = 10.0

class PostTableViewCell: UITableViewCell {
	
	var delegate:PostTableViewCellDelegate?
	
	@IBOutlet private weak var headerView: UIView! {
		didSet { headerView.translatesAutoresizingMaskIntoConstraints = false }
	}
	
	@IBOutlet private weak var postContentView: UIView! {
		didSet { postContentView.translatesAutoresizingMaskIntoConstraints = false }
	}
	
	@IBOutlet private weak var footerView: UIView! {
		didSet { footerView.translatesAutoresizingMaskIntoConstraints = false }
	}
	
	@IBOutlet private weak var authorImageView: UIImageView!
	@IBOutlet private weak var authorNameLabel: UILabel!
	@IBOutlet private weak var dateLabel: UILabel!
	@IBOutlet private weak var postTextLabel: UILabel!
	@IBOutlet private weak var postImageView: UIImageView!
	@IBOutlet private weak var likesLabel: UILabel!
	@IBOutlet private weak var commentsLabel: UILabel!
	@IBOutlet private weak var repostsLabel: UILabel!
	@IBOutlet private weak var viewsLabel: UILabel!
	@IBOutlet private weak var showMoreButton: UIButton!
	@IBOutlet private weak var postImageHeightConstraint: NSLayoutConstraint!
	@IBOutlet private weak var postTextLabelHeightConstraint: NSLayoutConstraint!
	
	var viewModel: PostCellViewModel? {
		didSet {
			guard let vm = viewModel else { return }
			
			authorImageView.imageFromURL(vm.authorImage)
			authorNameLabel.text = vm.authorName
			dateLabel.text = vm.date
			postTextLabel.text = vm.text
			likesLabel.text = vm.likes
			commentsLabel.text = vm.comments
			repostsLabel.text = vm.reposts
			
			postTextLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
			postTextLabel.sizeToFit()
			
			if vm.postImageHeight == 0 {
				postImageHeightConstraint.constant = 0
			}
			else {
				let ratio = CGFloat(vm.postImageWidth / vm.postImageHeight)
				
				let imageHeight = self.contentView.frame.width / ratio;
				postImageHeightConstraint.constant = ceil(imageHeight)
				
				postImageView.imageFromURL(vm.postImage)
			}
		}
	}
	
	@IBAction func showMoreButtonClick(_ sender: Any) {
		delegate?.reloadCell(cell: self)
	}
		
	override func layoutSubviews() {
		super.layoutSubviews()
		
		setHeaderViewFrame()
		setPostContentViewViewFrame()
		setFooterViewViewFrame()
	}
	
	func setShowMoreButtonTitle (expanded: Bool) {
		showMoreButton.setTitle(expanded ? "Скрыть" : "Показать полностью...", for: .normal)
	}
	
	func setPostTextLabelHeight (expanded: Bool) {
		guard expanded else {
			postTextLabelHeightConstraint.constant = 200
			return
		}
		if let text = postTextLabel.attributedText {
			let postTextHeight = text.height(withWidth: postTextLabel.frame.width)
			postTextLabelHeightConstraint.constant = postTextHeight
		}
	}
	
	func hideShowMoreButton(expanded: Bool) {
		if expanded {
			return
		}
		if let text = postTextLabel.attributedText {
			let textHeight = text.height(withWidth: postTextLabel.frame.width)
			if (textHeight < postTextLabel.frame.height) {
				showMoreButton.isHidden =  true
			}
		}
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

extension NSAttributedString {
	func height(withWidth width: CGFloat) -> CGFloat {
		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

		return ceil(boundingBox.height)
	}
}
