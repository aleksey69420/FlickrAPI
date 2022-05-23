//
//  FlickrPhoto.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/17/22.
//

import Foundation

struct FlickrPhoto: Codable {
	let id: String
	let owner: String
	let secret: String
	let server: String
	let farm: Int
	
	
	func imageURL(size: String = "m") -> URL? {
		return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_\(size).jpg")
	}
}


struct FlickrResultsPage: Codable {
	let page: Int
	let pages: Int
	let photo: [FlickrPhoto]
}
