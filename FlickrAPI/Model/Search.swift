//
//  Search.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/30/22.
//

import Foundation

class Search: Codable {
	
	//TODO: - link type to configured network endpoint options
	let type: String
	var isFavorite: Bool
	
	init(type: String, isFavorite: Bool = false) {
		self.type = type
		self.isFavorite = isFavorite
	}
}
