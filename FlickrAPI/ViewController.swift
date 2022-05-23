//
//  ViewController.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/17/22.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		
		
		NetworkManager.request(endpoint: FlickEndPoint.getSearchResults(searchText: "flowers", page: 1)) { (result: Result<FlickrResponse, Error>) in
			
			switch result {
			case .success(let response):
				print("success - \(response)")
				print("success - \(response.photos?.photo[0].imageURL(size: "m"))")
				//self.photos = response.photos?.photo ?? []
			case .failure(let error):
				print("failure - \(error)")
			}
		}
	}
}

