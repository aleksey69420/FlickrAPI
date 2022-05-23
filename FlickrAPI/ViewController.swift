//
//  ViewController.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/17/22.
//

import UIKit

class ViewController: UIViewController {
	
	let imageView = UIImageView()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		configure()
		
		NetworkManager.request(endpoint: FlickEndPoint.interestingPhotos(page: 1)) { (result: Result<FlickrResponse, Error>) in
			switch result {
			case .success(let response):
				print("success: \(response.photosInfo.photos) interesting photos")
				self.updateImageView(with: response.photosInfo.photos.first!)
			case .failure(let error):
				print("failure - \(error)")
			}
		}
	}
	
	private func updateImageView(with photo: FlickrPhoto) {
		NetworkManager.fetchImage(for: photo) { result in
			switch result {
			case .success(let image):
				self.imageView.image = image
			case .failure(let error):
				print("error fetching image: \(error)")
			}
		}
	}
	
	
	private func configure() {
		view.backgroundColor = .systemBackground
		
		view.addSubview(imageView)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		
		NSLayoutConstraint.activate([
			imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			imageView.topAnchor.constraint(equalTo: view.topAnchor),
			imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}

