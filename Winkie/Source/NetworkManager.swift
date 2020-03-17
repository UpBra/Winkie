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
		let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: .main)

		let handler = ResultTypeDataTaskHandler(request: request, block: completion)

		// This should be configurable. data vs download task
		let task = session.dataTask(with: urlRequest) { (data, response, error) in
			DispatchQueue.main.async {
				handler.handleDataTask(data: data, response: response, error: error)
			}
		}

		task.resume()
	}
}


private struct ResultTypeDataTaskHandler<R: NetworkRequest> {
	let request: R
	let block: R.Handler

	func handleDataTask(data: Data?, response: URLResponse?, error: Error?) {
		guard let data = data, error == nil else {
			block(.failure(error ?? ResponseError.invalidResponse))
			return
		}

		do {
			let result = try request.decode(data: data)
			block(.success(result))
		} catch {
			block(.failure(error))
		}
	}
}


public enum ResponseError: Error {
	case invalidRequest
	case invalidResponse
}
