//
//  SearchStore.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/31/22.
//

import Foundation

//TODO: - protocol naming and definitions... - work on it!

protocol SearchStore {
	var searches: [Search] { get }
	func getFavorites() -> [Search]
	func saveChanges() -> Error?
}


class JSONSearchStore: SearchStore {
	
	//TODO: - move to the JSON file as a part of the Bundle
	//TODO: - change it to be created dynamically based on configured number of Flick EndPoints
	let hardcodedSearches = [
		Search(type: "Intersting Photos", isFavorite: false),
		Search(type: "Search by Name Photos", isFavorite: false),
		Search(type: "Search by Place", isFavorite: false),
		Search(type: "Search by My Location", isFavorite: false)
	]
	
	
	private let fileURL: URL = {
		var documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
		return documentDirectory.appendingPathComponent("searchType.json")
	}()
	
	
	var searches: [Search] = []
	
	
	init() {
		do {
			let data = try Data(contentsOf: fileURL)
			let decoder = JSONDecoder()
			let searches = try decoder.decode([Search].self, from: data)
			self.searches = searches
		} catch {
			Log.error(error.localizedDescription)
			self.searches = hardcodedSearches
			self.saveChanges()
		}
	}
	
	func getFavorites() -> [Search] {
		let favorites = searches.filter({ option in
			option.isFavorite == true
		})
		return favorites
	}
	
	
	@discardableResult func saveChanges() -> Error? {
		Log.info("Saving items to URL")
		
		do {
			let encoder = JSONEncoder()
			let data = try encoder.encode(searches)
			try data.write(to: fileURL)
			return nil
		} catch let encodingError {
			Log.error("Error enconding: \(encodingError) ")
			return encodingError
		}
	}
}
