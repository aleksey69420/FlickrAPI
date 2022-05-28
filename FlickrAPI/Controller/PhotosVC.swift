//
//  PhotosVC.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/17/22.
//

import UIKit

class PhotosVC: UIViewController {
	
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
		collectionView.delegate = self
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


extension PhotosVC: UICollectionViewDelegate {
	
	// fetching image there - new approach for me - don't like it
	// is there other option to achieve the same result?
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		
		let photo = photoDataSource.photos[indexPath.item]
		
		NetworkManager.fetchImage(for: photo) { result in
			
			//index path for the photo might have changed between the time request started and finished, so find the most recent index path
			
			if let photoIndex = self.photoDataSource.photos.firstIndex(of: photo) {
				let photoIndexPath = IndexPath(item: photoIndex, section: 0)
				switch result {
				case .success(let image):
					if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCell {
						cell.update(displaying: image)
					}
				case .failure: break
				}
				
			}
		}
	}
	
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let photoDetailVC = PhotoDetailVC(photo: photoDataSource.photos[indexPath.item])
		navigationController?.pushViewController(photoDetailVC, animated: true)
	}
}
