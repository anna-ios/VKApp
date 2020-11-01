//
//  ImageCachingService.swift
//  VKApp
//
//  Created by Zelinskaya Anna on 30.10.2020.
//  Copyright © 2020 Zelinskaya Anna. All rights reserved.
//

import Alamofire
import UIKit

protocol ImageCachingServiceDelegate {
	func reloadRow(indexPath: IndexPath)
}

class ImageCachingService {
	
	var delegate:ImageCachingServiceDelegate?
	
	static let sharedManager: SessionManager = {
		let config = URLSessionConfiguration.default
		config.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
		config.timeoutIntervalForRequest = 40
		return Alamofire.SessionManager(configuration: config)
	}()

	private static let imagesCashesDirectory: URL? = {
		guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("Images") else {
			return nil
		}
		if !FileManager.default.fileExists(atPath: url.path) {
			try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
		}
		return url
	}()

	private var images = [String: UIImage]()
	
	private func imagePath(url: String) -> String? {
		let imageName = (url as NSString).lastPathComponent
		return ImageCachingService.imagesCashesDirectory?.appendingPathComponent(imageName).path
	}
	
	private func saveCachedImage(url: String, image: UIImage) {
		guard let localImagePath = imagePath(url: url),
			  let imageData = image.pngData() else { return }

		FileManager.default.createFile(atPath: localImagePath, contents: imageData, attributes: nil)
	}

	private func cachedImage(url: String) -> UIImage? {
		guard let localImagePath = imagePath(url: url) else { return nil }
		return UIImage(contentsOfFile: localImagePath)
	}

	private func loadImage(atIndexPath indexPath: IndexPath, byUrl url: String) {
		ImageCachingService.sharedManager.request(url).responseData(
			queue: DispatchQueue.global(),
			completionHandler: { [weak self] response in
				guard let data = response.data,
					  let image = UIImage(data: data) else { return }

				self?.addImage(image: image, withUrl: url)
				self?.saveCachedImage(url: url, image: image)
				self?.delegate?.reloadRow(indexPath: indexPath)
			}
		)
	}
	private func addImage(image: UIImage, withUrl url: String) {
		DispatchQueue.main.async { [weak self] in
			self?.images[url] = image
		}
	}

	func getImage(atIndexPath indexPath: IndexPath, byUrl url: String) -> UIImage? {
		if (url.isEmpty) {
			return nil
		}
		if let image = images[url] {
			return image
		}
		if let image = cachedImage(url: url) {
			self.addImage(image: image, withUrl: url)
			return image
		}
		
		loadImage(atIndexPath: indexPath, byUrl: url)
		return nil
	}
}
