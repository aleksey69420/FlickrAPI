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
	var selectedOptions: [String] = ["Interested Photos", "Search by Name"]
	
}
