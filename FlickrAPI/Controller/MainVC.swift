//
//  MainVC.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/25/22.
//

import UIKit

class MainVC: UIViewController {
	
	let searchOptionsManager: SearchOptionsManager
	
	let tableView = UITableView()
	
	
	init(searchOptionsManager: SearchOptionsManager = SearchOptionsManager()) {
		self.searchOptionsManager = searchOptionsManager
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configure()
		print(searchOptionsManager.allOptions)
	}
	
	
	private func configure() {
		view.backgroundColor = .systemBackground
		title = "Select Search Option"
		
		
		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.rowHeight = 80
		tableView.register(SearchOptionCell.self, forCellReuseIdentifier: SearchOptionCell.reuseId)
		
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
		return searchOptionsManager.selectedOptions.count
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let searchName = searchOptionsManager.selectedOptions[indexPath.row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: SearchOptionCell.reuseId, for: indexPath) as! SearchOptionCell
		cell.iconImageView.image = UIImage(systemName: "magnifyingglass.circle")
		cell.titleLabel.text = searchName
		return cell
	}
}
