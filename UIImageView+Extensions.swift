//
//  UIImageView+Extensions.swift
//  VKApp
//
//  Created by Zelinskaya Anna on 15.10.2020.
//  Copyright © 2020 Zelinskaya Anna. All rights reserved.
//

import UIKit

extension UIImageView {
	func imageFromURL(_ imageUrl: String) {
		DispatchQueue.global().async { [weak self] in
			if let url = URL(string: imageUrl) {
				URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
					DispatchQueue.main.async {
						if let data = data {
							if let downloadedImage = UIImage(data: data) {
								self?.image = downloadedImage
							}
						}
					}
				}).resume()
			}
		}
	}
}
