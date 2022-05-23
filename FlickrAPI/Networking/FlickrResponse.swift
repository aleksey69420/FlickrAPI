//
//  FlickrResponse.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/17/22.
//

import Foundation

// is this work as typealias or something similar
// jsut to have a simple type?


struct FlickrResponse: Codable {
	let photosInfo: FlickrPhotosResponse
	
	enum CodingKeys: String, CodingKey {
		case photosInfo = "photos"
	}
}
