//
//  PhotoDetailVC.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/25/22.
//

import UIKit

class PhotoDetailVC: UIViewController {
	
	let imageView = UIImageView()
	
	let photo: FlickrPhoto
	
	init(photo: FlickrPhoto) {
		self.photo = photo
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configure()
		fetchImage()
	}
	
	
	private func configure() {
		view.backgroundColor = .systemBackground
		title = photo.title
		
		view.addSubview(imageView)
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		
		
		NSLayoutConstraint.activate([
			imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	
	private func fetchImage() {
		if let image = NetworkManager.cache.object(forKey: photo.id as NSString) {
			imageView.image = image
		} else {
			// spin, placeholder, set the size in advance (available)
			print("have to fetch image from internet")
		}
	}
}
