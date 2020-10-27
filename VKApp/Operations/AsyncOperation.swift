//
//  AsyncOperation.swift
//  VKApp
//
//  Created by Zelinskaya Anna on 15.10.2020.
//  Copyright © 2020 Zelinskaya Anna. All rights reserved.
//

import UIKit

class AsyncOperation: Operation {
	enum State: String {
		case ready
		case executing
		case finishing
		case finished
	}
	
	var state: State = .ready {
		willSet {
			willChangeValue(forKey: state.rawValue)
			willChangeValue(forKey: newValue.rawValue)
		}
		didSet {
			didChangeValue(forKey: oldValue.rawValue)
			didChangeValue(forKey: state.rawValue)
		}
	}
	
	override var isAsynchronous: Bool {
		return true
	}
	
	override var isReady: Bool {
		return super.isReady && state == .ready
	}

	override var isExecuting: Bool {
		return state == .executing
	}
	
	override var isFinished: Bool {
		return state == .finished
	}

	override func start() {
		if isCancelled {
			state = .finished
		} else {
			state = .executing
			operationDidStart()
		}
	}

	override func cancel() {
		super.cancel()
		state = .finished
	}

	final func finish() {
		state = .finished
	}
	
	func operationDidStart() { }
}
