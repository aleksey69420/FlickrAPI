//
//  SearchStore.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/31/22.
//

import Foundation

//TODO: - protocol naming and definitions... - work on it!

protocol SearchStore {
	var searchTypes: [SearchOption] { get }
	func getFavorites() -> [SearchOption]
	func saveChanges() -> Error?
}


class JSONSearchStore: SearchStore {
	
	//TODO: - move to the JSON file as a part of the Bundle
	//TODO: - change it to be created dynamically based on configured number of Flick EndPoints
	let initialSearchTypes = [
		SearchOption(name: "Intersting Photos", isFavorite: false),
		SearchOption(name: "Search by Name Photos", isFavorite: false),
		SearchOption(name: "Search by Place", isFavorite: false),
		SearchOption(name: "Search by My Location", isFavorite: false)
	]
	
	
	private let fileURL: URL = {
		var documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
		return documentDirectory.appendingPathComponent("searchType.json")
	}()
	
	
	var searchTypes: [SearchOption] = []
	
	
	init() {
		do {
			let data = try Data(contentsOf: fileURL)
			let decoder = JSONDecoder()
			let searches = try decoder.decode([SearchOption].self, from: data)
			self.searchTypes = searches
		} catch {
			Log.error(error.localizedDescription)
			self.searchTypes = initialSearchTypes
			self.saveChanges()
		}
	}
	
	func getFavorites() -> [SearchOption] {
		let favorites = searchTypes.filter({ option in
			option.isFavorite == true
		})
		return favorites
	}
	
	
	@discardableResult func saveChanges() -> Error? {
		Log.info("Saving items to URL")
		
		do {
			let encoder = JSONEncoder()
			let data = try encoder.encode(searchTypes)
			try data.write(to: fileURL)
			return nil
		} catch let encodingError {
			Log.error("Error enconding: \(encodingError) ")
			return encodingError
		}
	}
}
