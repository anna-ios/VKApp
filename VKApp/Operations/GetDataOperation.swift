//
//  GetDataOperation.swift
//  VKApp
//
//  Created by Zelinskaya Anna on 15.10.2020.
//  Copyright © 2020 Zelinskaya Anna. All rights reserved.
//

import UIKit
import VK_ios_sdk

class GetDataOperation: AsyncOperation {
	
	var response: VKResponse<VKApiObject>?
	private var request: VKRequest

	init(req: VKRequest) {
		request = req
	}
	
	override func operationDidStart() {
		super.operationDidStart()
		request.execute(resultBlock: { resp in
			self.response = resp
			self.state = .finished
		}, errorBlock: { error in
			print(error ?? "")
		})
	}

}
