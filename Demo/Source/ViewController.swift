// —————————————————————————————————————————————————————————————————————————
//
//	ViewController.swift
//	Copyright © 2019 gleesh. All rights reserved.
//
// —————————————————————————————————————————————————————————————————————————

import UIKit
import Winkie


class ViewController: UIViewController {


	// MARK: - Properties

	private let networkManager = NetworkManager()
}


// MARK: - UIViewController Overrides

extension ViewController {

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		testPostsRequest()
	}
}

// MARK: - Private

extension ViewController {

	private func testPostsRequest() {
		let request = PostsRequest(string: Endpoint.Placeholder.users)

		networkManager.load(request: request) { (result, error) in
			guard let result = result else { print(String(describing: error)); return }

			print(result)
		}

		let imageRequest = FillMurrayRequest(width: 320, height: 480)

		networkManager.load(request: imageRequest) { (image, error) in
			guard let image = image else { print(String(describing: error)); return }

			DispatchQueue.main.async { [weak self] in
				guard let this = self else { return }

				let imageView = UIImageView(image: image)
				this.view.addSubview(imageView)
			}
		}
	}
}
