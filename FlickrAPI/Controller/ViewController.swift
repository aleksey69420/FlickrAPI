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
		
		collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseId)
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
