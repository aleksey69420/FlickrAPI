//
//  MainVC.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/25/22.
//

import UIKit

class MainVC: UIViewController {
	
	let searchStore: SearchStore
	var favoriteSearches: [Search] = []
	
	let tableView = UITableView()
	
	
	init(searchStore: SearchStore = JSONSearchStore()) {
		self.searchStore = searchStore
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.triangle"), style: .plain, target: self, action: #selector(showAvalableSearchOptions(_:)))
		
		configure()
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		favoriteSearches = searchStore.getFavorites()
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
	
	/*
	private func getSearchOptions() {
		searchOptionsManager.retriveFavorites { result in
			switch result {
			case .success(let options):
				self.updateUI(with: options)
			case .failure(let error):
				print("error - \(error.localizedDescription)")
			}
		}
	}
	*/
	
	/*
	private func updateUI(with options: [String]) {
		if options.isEmpty {
			// show empty state view
			print("no options selected - please a nice placeholder image")
		} else {
			self.searchOptions = options
			DispatchQueue.main.async {
				self.tableView.reloadData()
				//self.view.bringSubviewToFront(self.tableView) // in case if empty state create first
			}
		}
	}
	*/
	
	@objc private func showAvalableSearchOptions(_ sender: UIBarButtonItem) {
		let searchOptionsVC = SearchOptionsVC(searchStore: searchStore)
		navigationController?.pushViewController(searchOptionsVC, animated: true)
	}
	
	
	private func configure() {
		view.backgroundColor = .systemBackground
		title = "Search Photos"
		navigationController?.navigationBar.prefersLargeTitles = true
		
		
		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.rowHeight = 80
		tableView.register(SearchOptionCell.self, forCellReuseIdentifier: SearchOptionCell.reuseId)
		
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

extension MainVC: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return favoriteSearches.count
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let search = favoriteSearches[indexPath.row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: SearchOptionCell.reuseId, for: indexPath) as! SearchOptionCell
		cell.iconImageView.image = UIImage(systemName: "magnifyingglass.circle")
		cell.titleLabel.text = search.type
		return cell
	}
}


extension MainVC: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		
		guard editingStyle == .delete else { return }
		
		/*
		searchOptionsManager.updateWith(favorite: searchOptions[indexPath.row], actionType: .remove) { [weak self] error in
			
			guard let self = self else { return }
			
			guard let error = error else {
				self.searchOptions.remove(at: indexPath.row) // fetch data instead?
				tableView.reloadData()
				return
			}
			
			print("error removing item \(error.localizedDescription)")
		}
		 */
	}
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		tableView.deselectRow(at: indexPath, animated: true)
		navigationController?.pushViewController(PhotosVC(), animated: true)
	}
}
