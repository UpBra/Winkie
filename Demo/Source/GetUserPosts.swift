// —————————————————————————————————————————————————————————————————————————
//
//	GetUserPosts.swift
//	Copyright © 2019 gleesh. All rights reserved.
//
// —————————————————————————————————————————————————————————————————————————

import Winkie


enum Endpoint {

	enum Placeholder {
		static let users = "https://jsonplaceholder.typicode.com/posts"
	}
}


struct PostResponse: Codable {
	let userId: Int
	let id: Int
	let title: String
	let body: String
}


struct PostsRequest: NetworkRequest {

	typealias ResultType = [PostResponse]

	var request: URLRequest?

	init(string: String) {
		guard let url = URL(string: string) else { return }

		request = URLRequest(url: url)
	}
}
