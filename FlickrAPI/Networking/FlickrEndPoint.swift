//
//  FlickrEndPoint.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/17/22.
//

import Foundation


protocol EndPoint {
	var scheme: String { get } //http or https
	var baseURL: String { get } //
	var path: String { get }
	var parameters: [URLQueryItem] { get }
	var method: String { get }
}


// Enum as a choice - adding a new end point with force to provide all the required information
enum FlickEndPoint: EndPoint {
	
	case getSearchResults(searchText: String, page: Int)
	
	
	var scheme: String {
		switch self {
		default: return "https"
		}
	}
	
	
	var baseURL: String {
		switch self {
		default: return "api.flickr.com"
		}
	}
	
	
	var path: String {
		switch self {
		case .getSearchResults:
			return "/services/rest/"
		}
	}
	
	
	var parameters: [URLQueryItem] {
		
		let apiKey = "e64b3ac5f1aada47c6436406cd313196"
		
		switch self {
		case .getSearchResults(let searchText, let page):
			return [
				URLQueryItem(name: "text", value: searchText),
				URLQueryItem(name: "page", value: String(page)),
				URLQueryItem(name: "method", value: "flickr.photos.search"), // what does it mean?
				URLQueryItem(name: "format", value: "json"),
				URLQueryItem(name: "per_page", value: "20"),
				URLQueryItem(name: "nojsoncallback", value: "1"),
				URLQueryItem(name: "api_key", value: apiKey),
			]
		}
	}
	
	
	var method: String {
		switch self {
		case .getSearchResults:
			return "GET"
		}
	}
}
