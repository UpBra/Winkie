// —————————————————————————————————————————————————————————————————————————
//
//	NetworkRequest.swift
//	Copyright © 2020 gleesh. All rights reserved.
//
// —————————————————————————————————————————————————————————————————————————


public protocol ResultType {
	associatedtype ResultType
}


public protocol ResultTypeDecodable: ResultType {
	func decode(file: URL) throws -> ResultType?
	func decode(data: Data) throws -> ResultType?
}


public extension ResultTypeDecodable {

	func decode(file: URL) throws -> ResultType? {
		let data = try Data(contentsOf: file)
		let result = try decode(data: data)

		return result
	}
}


public extension ResultTypeDecodable where ResultType: Codable {

	func decode(data: Data) throws -> ResultType? {
		let result = try JSONDecoder().decode(ResultType.self, from: data)

		return result
	}
}


public protocol ResultTypeHandleable: ResultType {
	typealias Handler = (ResultType?, Error?) -> Void
}


public protocol NetworkRequest: ResultTypeDecodable, ResultTypeHandleable {
	var request: URLRequest? { get }
}
