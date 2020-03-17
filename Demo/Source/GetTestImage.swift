// —————————————————————————————————————————————————————————————————————————
//
//	GetTestImage.swift
//	Copyright © 2019 gleesh. All rights reserved.
//
// —————————————————————————————————————————————————————————————————————————

import UIKit
import Winkie


extension Endpoint {

	static let fillMurray = "https://www.fillmurray.com"
}


struct FillMurrayRequest: NetworkRequest {

	typealias ResultType = UIImage

	var request: URLRequest?

	init(width: Int, height: Int) {
		var urlComponents = URLComponents(string: Endpoint.fillMurray)

		urlComponents?.path = "/\(width)/\(height)"

		guard let components = urlComponents else { return }
		guard let url = components.url else { return }

		request = URLRequest(url: url)
	}

	func decode(data: Data) throws -> FillMurrayRequest.ResultType {
		guard let image = UIImage(data: data) else { throw ResponseError.invalidResponse }

		return image
	}
}
