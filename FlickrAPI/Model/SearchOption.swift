//
//  SearchOption.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/30/22.
//

import Foundation

class SearchOption {
	
	let name: String
	var isFavorite: Bool
	
	init(name: String, isFavorite: Bool = false) {
		self.name = name
		self.isFavorite = isFavorite
	}
}
