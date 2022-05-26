//
//  SearchOptionsManager.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/25/22.
//

import Foundation

//protocol - allItems, saveitem, save, delete, update?, reorder?

class SearchOptionsManager {
	
	//TODO: - show all options with the checkmark for the selected ones (convert to model)
	//TODO: - each option may have an icon (user can change it?) - custom object or viewModel?
	var allOptions = ["Intersting Photos", "Search by Name", "Search by Place", "Search by Tag", "Search by Coordinates"]
	//var selectedOptions: [String] = ["Interested Photos", "Search by Name"]
	
	
	private let userDefaults = UserDefaults.standard
	
	
	enum Keys {
		static let favorites = "favorites"
	}
	
	
	func retriveFavorites(handler: @escaping (Result<[String], Error>) -> Void) {
		
		guard let favoritesData = userDefaults.object(forKey: Keys.favorites) as? Data else {
			handler(.success([]))
			return
		}
		
		do {
			let favorites = try JSONDecoder().decode([String].self, from: favoritesData)
			handler(.success(favorites))
		} catch {
			handler(.failure(error))
		}
	}
	
	
	func save(favorites: [String]) -> Error? {
		do {
			let encodedFavorites = try JSONEncoder().encode(favorites)
			userDefaults.set(encodedFavorites, forKey: Keys.favorites)
			return nil
		} catch {
			return error
		}
	}
}
