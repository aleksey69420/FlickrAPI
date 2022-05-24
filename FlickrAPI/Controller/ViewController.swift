//
//  ViewController.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/17/22.
//

import UIKit

class ViewController: UIViewController {
	
	//var photos: [FlickrPhoto] = []
	var collectionView: UICollectionView!
	let photoDataSource = PhotoDataSource()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureCollectionView()
		configure()
		
		NetworkManager.request(endpoint: FlickEndPoint.interestingPhotos(page: 1)) { (result: Result<FlickrResponse, Error>) in
			switch result {
			case .success(let response):
				self.photoDataSource.photos = response.photosInfo.photos
				self.collectionView.reloadData()
			case .failure(let error):
				print("failure - \(error)")
				self.photoDataSource.photos.removeAll()
			}
			self.collectionView.reloadSections(IndexSet(integer: 0))
		}
	}
	
	
	private func configureCollectionView() {
		let layout = UIHelper.createTwoColumnFlowLayout(view: view)
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		
		collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseId)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.backgroundColor = .clear
		
		collectionView.dataSource = photoDataSource
	}
	
	
	private func configure() {
		view.backgroundColor = .systemBackground
		title = "Interesting Photos"
		
		view.addSubview(collectionView)
		
		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.topAnchor.constraint(equalTo: view.topAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}


//extension ViewController: UICollectionViewDataSource {
//
//	func numberOfSections(in collectionView: UICollectionView) -> Int {
//		return 1
//	}
//
//
//	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//		return photos.count
//	}
//
//
//	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//		let photo = photos[indexPath.item]
//		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseId, for: indexPath) as! ImageCell
//		NetworkManager.fetchImage(for: photo, then: { result in
//			switch result {
//			case .success(let image):
//				cell.imageView.image = image
//			case .failure(let error):
//				print("error downloading image: \(error)")
//			}
//		})
//		return cell
//	}
//}


class ImageCell: UICollectionViewCell {
	
	static let reuseId = String(describing: ImageCell.self)
	
	let imageView = UIImageView(frame: .zero)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	private func configure() {
		backgroundColor = .systemBlue
		
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		addSubview(imageView)
		
		let padding: CGFloat = 8
		
		NSLayoutConstraint.activate([
			imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
			imageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
			imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
			imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
		])
	}
}
