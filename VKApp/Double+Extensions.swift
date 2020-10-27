//
//  Double+Extensions.swift
//  VKApp
//
//  Created by Zelinskaya Anna on 19.10.2020.
//  Copyright © 2020 Zelinskaya Anna. All rights reserved.
//

import Foundation

extension Double {
	func dateFromDouble() -> String {
		let df = DateFormatter()
		df.dateFormat = "yyyy-MM-dd hh:mm:ss"
		let strDate = df.string(from: Date(timeIntervalSince1970: self))
		return strDate
	}
}
