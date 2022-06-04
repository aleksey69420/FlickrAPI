//
//  ImageStore.swift
//  FlickrAPI
//
//  Created by Aleksey on 6/1/22.
//


import UIKit

protocol ImageStore {
	func saveImage(_ image: UIImage, forKey key: String)
	func getImage(forKey key: String) -> UIImage?
	func deleleImage(forKey key: String)
}


class CacheImageStore: ImageStore {
	
	private let cache = NSCache<NSString, UIImage>()
	
	
	func saveImage(_ image: UIImage, forKey key: String) {
		let cacheKey = key as NSString
		cache.setObject(image, forKey: cacheKey)
		print("just saved image in cache")
	}
	
	
	func getImage(forKey key: String) -> UIImage? {
		let cacheKey = key as NSString
		
		if let image = cache.object(forKey: cacheKey) {
			print("got image from cache")
			return image
		} else {
			print("no image - returning nil")
			return nil
		}
	}
	
	
	func deleleImage(forKey key: String) {
		let cacheKey = key as NSString
		cache.removeObject(forKey: cacheKey)
	}
}
