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

		networkManager.load(request: request) { (result) in
			switch result {
			case .success(let object):
				print(object)

			case .failure(let error):
				print(String(describing: error))
			}
		}

		let imageRequest = FillMurrayRequest(width: 320, height: 480)

		networkManager.load(request: imageRequest) { (result) in
			DispatchQueue.main.async { [weak self] in
				guard let this = self else { return }

				switch result {
				case .success(let image):
					let imageView = UIImageView(image: image)
					this.view.addSubview(imageView)

				case .failure(let error):
					print(String(describing: error))
				}
			}
		}
	}
}
