//
//  MainVC.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/25/22.
//

import UIKit

class MainVC: UIViewController {
	
	let tableView = UITableView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configure()
	}
	
	
	private func configure() {
		view.backgroundColor = .systemBackground
		title = "Select Search Option"
		
		
		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.frame = view.bounds
		
		tableView.dataSource = self
		
		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		
		
	}
}

extension MainVC: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
	
	
}
