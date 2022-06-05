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
	
	let fileManager = FileManager.default
	
	
	func saveImage(_ image: UIImage, forKey key: String) {
		let cacheKey = key as NSString
		cache.setObject(image, forKey: cacheKey)
		print("just saved image in cache")
		
		let url = imageURL(forKey: key)
		
		if let data = image.jpegData(compressionQuality: 0.5) {
			try? data.write(to: url)
			print("just saved image on disk")
		}
		
	}
	
	
	func getImage(forKey key: String) -> UIImage? {
		let cacheKey = key as NSString
		
		if let imageFromCache = cache.object(forKey: cacheKey) {
			print("got image from cache")
			return imageFromCache
		}
		
		let url = imageURL(forKey: key)
		guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
			print("no image on disk - nil")
			return nil
		}
		
		print("got image from disk - \(imageFromDisk)")
		cache.setObject(imageFromDisk, forKey: cacheKey)
		return imageFromDisk
	}
	
	
	func deleleImage(forKey key: String) {
		let cacheKey = key as NSString
		cache.removeObject(forKey: cacheKey)
		
		let url = imageURL(forKey: key)
		do {
			try fileManager.removeItem(at: url)
		} catch {
			Log.error("error removing image from disk: \(error)")
		}
	}
	
	
	private func imageURL(forKey key: String) -> URL {
		let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
		return documentDirectory.appendingPathComponent(key)
	}
}
