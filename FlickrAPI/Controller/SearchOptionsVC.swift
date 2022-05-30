//
//  SearchOptionsVC.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/30/22.
//

import UIKit

class SearchOptionsVC: UIViewController {
	
	var availableOptions: [SearchOption]
	
	let searchOptionsManager: SearchOptionsManager
	
	let tableView = UITableView()
	
	
	init(searchOptionsManager: SearchOptionsManager) {
		self.searchOptionsManager = searchOptionsManager
		self.availableOptions = searchOptionsManager.allOptions
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
    override func viewDidLoad() {
        super.viewDidLoad()

		configure()
    }
	
	
	private func configure() {
		view.backgroundColor = .systemBackground
		title = "Search Options"
		
		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.rowHeight = 80
		tableView.register(SearchTypeCell.self, forCellReuseIdentifier: SearchTypeCell.reuseId)
		
		tableView.dataSource = self
		tableView.delegate = self
		
		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		
	}
}


extension SearchOptionsVC: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return availableOptions.count
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let searchOpiton = availableOptions[indexPath.row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: SearchTypeCell.reuseId, for: indexPath) as! SearchTypeCell
		
		cell.configure(for: searchOpiton)
		
		//cell.iconImageView.image = UIImage(systemName: "magnifyingglass.circle")
		//cell.titleLabel.text = searchName
		
		return cell
	}
}


extension SearchOptionsVC: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print(#function)
		tableView.deselectRow(at: indexPath, animated: true)
		
		let cell = tableView.cellForRow(at: indexPath) as! SearchTypeCell
		//cell.saved.toggle()
		print("\(cell.title) is selected")
		
		var option = availableOptions[indexPath.row]
		print(option.isFavorite)
		option.isFavorite.toggle()
		print(option.isFavorite)
		cell.configure(for: option)
		
	}
}
