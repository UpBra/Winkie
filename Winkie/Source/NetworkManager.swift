//	—————————————————————————————————————————————————————————————————————————
//
//	NetworkManager.swift
//	Copyright © 2020 gleesh. All rights reserved.
//
//	—————————————————————————————————————————————————————————————————————————

import Foundation


public class NetworkManager {

	public init() { }

	public func load<R: NetworkRequest>(request: R, completion: @escaping R.Handler) {
		guard let urlRequest = request.request else { completion(.failure(ResponseError.invalidRequest)); return }

		// This should be configurable. what session / configuration / delegate / queue
		let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: nil)

		// This should be configurable. data vs download task
		let task = session.dataTask(with: urlRequest) { (data, response, error) in
			guard let data = data, error == nil else {
				completion(.failure(error ?? ResponseError.invalidResponse))
				return
			}

			do {
				let result = try request.decode(data: data)
				completion(.success(result))
			} catch {
				completion(.failure(error))
			}
		}

		task.resume()
	}
}


public enum ResponseError: Error {
	case invalidRequest
	case invalidResponse
}
