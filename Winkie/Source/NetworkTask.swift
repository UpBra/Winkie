//	—————————————————————————————————————————————————————————————————————————
//
//	NetworkTask.swift
//	Copyright © 2020 gleesh. All rights reserved.
//
//	—————————————————————————————————————————————————————————————————————————

import Foundation


public class NetworkTask<Request: NetworkRequest> {

	// Need a network request
	public let request: Request

	// Need a network decorator
	public let decorator: NetworkRequestDecorator

	public init(request: Request, decorator: NetworkRequestDecorator) {
		self.request = request
		self.decorator = decorator
	}
}
