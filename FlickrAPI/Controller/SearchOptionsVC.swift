//
//  SearchOptionsVC.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/30/22.
//

import UIKit

class SearchOptionsVC: UIViewController {
		
	let searchStore: SearchStore
	
	let tableView = UITableView()
	
	
	init(searchStore: SearchStore) {
		self.searchStore = searchStore
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

		configure()
    }
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		searchStore.saveChanges()
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
		return searchStore.searches.count
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let searchOpiton = searchStore.searches[indexPath.row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: SearchTypeCell.reuseId, for: indexPath) as! SearchTypeCell
		cell.configure(for: searchOpiton)
		return cell
	}
}


extension SearchOptionsVC: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print(#function)
		tableView.deselectRow(at: indexPath, animated: true)
		
		let cell = tableView.cellForRow(at: indexPath) as! SearchTypeCell
		print("\(cell.title) is selected")
		
		let search = searchStore.searches[indexPath.row]
		search.isFavorite.toggle()
		cell.configure(for: search)
	}
}
