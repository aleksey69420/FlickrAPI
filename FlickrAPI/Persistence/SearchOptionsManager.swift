//
//  SearchOptionsManager.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/25/22.
//

import Foundation

//protocol - allItems, saveitem, save, delete, update?, reorder?

enum PersistenceActionType {
	case add
	case remove
}


class SearchOptionsManager {
	
	//TODO: - each option may have an icon (user can change it?) - custom object or viewModel?
	
	var allOptions = [Search(type: "Intersting Photos"), Search(type: "Search by Name Photos"), Search(type: "Search by Place"), Search(type: "Search by My Location"), ]
	
	
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
	
	
	//MARK - Update (Add or Remove)
	
	func updateWith(favorite: String, actionType: PersistenceActionType, then handler: @escaping (Error?) -> Void) {
		// get existing, do something, save changes
		
		retriveFavorites { result in
			
			switch result {
				// there is data
			case .success(var favorites):
				
				switch actionType {
				case .add:
					guard !favorites.contains(favorite) else {
						let error = NSError(domain: "", code: 200, userInfo: [ NSLocalizedDescriptionKey: "Item is already saved"])
						handler(error)
						return
					}
					
				case .remove:
					favorites.removeAll { toRemove in
						toRemove == favorite
					}
				}
				
				// completion of save matches the update - Error?
				handler(self.save(favorites: favorites))
			
				// handle no data case
			case .failure(let error):
				handler(error)
			}
		}
	}
}
