//	—————————————————————————————————————————————————————————————————————————
//
//	NetworkRequestDecorator.swift
//	Copyright © 2020 gleesh. All rights reserved.
//
//	—————————————————————————————————————————————————————————————————————————

import Foundation


public protocol NetworkRequestDecorator {
	func decorate<Request: NetworkRequest>(request: Request) -> URLRequest
}
