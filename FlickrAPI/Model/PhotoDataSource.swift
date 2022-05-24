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
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseId, for: indexPath)
		return cell
	}
	
	
	
	
}
