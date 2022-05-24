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
	let title: String
	let dateTaken: Date
	let remoteURL: URL?
	
	
	enum CodingKeys: String, CodingKey {
		case id
		case owner
		case secret
		case server
		case farm
		case title
		case dateTaken = "datetaken"
		case remoteURL = "url_z"
	}
	
	func imageURL(size: String = "m") -> URL? {
		return URL(string: "https://live.staticflickr.com/\(server)/\(id)_\(secret)_\(size).jpg")
	}
}


struct FlickrPhotosResponse: Codable {
	let page: Int
	let pages: Int
	let total: Int
	let photos: [FlickrPhoto]
	
	enum CodingKeys: String, CodingKey {
		case page
		case pages
		case total
		case photos = "photo"
	}
}
