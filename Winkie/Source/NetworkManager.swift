// —————————————————————————————————————————————————————————————————————————
//
//	NetworkManager.swift
//	Copyright © 2020 gleesh. All rights reserved.
//
// —————————————————————————————————————————————————————————————————————————


public class NetworkManager {

	public init() { }

	public func load<R: NetworkRequest>(request: R, completion: @escaping R.Handler) {
		guard let urlRequest = request.request else { completion(nil, LoadError.invalidRequest); return }

		// This should be configurable. what session / configuration / delegate / queue
		let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: nil)

		// This should be configurable. data vs download task
		let task = session.dataTask(with: urlRequest) { (data, response, error) in
			guard error == nil else { completion(nil, error); return }
			guard let data = data else { completion(nil, error); return }

			do {
				let result = try request.decode(data: data)
				completion(result, nil)
			} catch {
				completion(nil, error)
			}
		}

		task.resume()
	}
}


public extension NetworkManager {

	enum LoadError: Error {
		case invalidRequest
	}
}
