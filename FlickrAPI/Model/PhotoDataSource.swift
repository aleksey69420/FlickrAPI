//
//  PhotoDataSource.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/24/22.
//

import UIKit

class PhotoDataSource: NSObject, UICollectionViewDataSource {
	var photos: [FlickrPhoto] = []
	
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return photos.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseId, for: indexPath) as! PhotoCell
		
		
		let photo = photos[indexPath.item]
		
		NetworkManager.fetchImage(for: photo, then: { result in
			switch result {
			case .success(let image):
				cell.update(displaying: image)
			case .failure(let error):
				print("error downloading image: \(error)")
			}
		})
		
		return cell
	}
}
