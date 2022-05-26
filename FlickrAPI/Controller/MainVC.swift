//
//  MainVC.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/25/22.
//

import UIKit

class MainVC: UIViewController {
	
	let searchOptionsManager: SearchOptionsManager
	
	var searchOptions: [String] = []
	
	let tableView = UITableView()
	
	
	init(searchOptionsManager: SearchOptionsManager = SearchOptionsManager()) {
		self.searchOptionsManager = searchOptionsManager
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configure()
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		getSearchOptions()
	}
	
	
	private func getSearchOptions() {
		//TODO: - retrieve selected options for defaults and update UI (thread?) or show error message
		let tempSearchOptions = searchOptionsManager.selectedOptions //
		
		updateUI(with: tempSearchOptions)
	}
	
	
	private func updateUI(with options: [String]) {
		if options.isEmpty {
			// show empty state view
		} else {
			self.searchOptions = options
			DispatchQueue.main.async {
				self.tableView.reloadData()
				//self.view.bringSubviewToFront(self.tableView) // in case if empty state create first
			}
		}
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
		return searchOptions.count
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let searchName = searchOptions[indexPath.row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: SearchOptionCell.reuseId, for: indexPath) as! SearchOptionCell
		cell.iconImageView.image = UIImage(systemName: "magnifyingglass.circle")
		cell.titleLabel.text = searchName
		return cell
	}
}
