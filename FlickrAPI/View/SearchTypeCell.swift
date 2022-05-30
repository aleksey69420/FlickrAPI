//
//  SearchTypeCell.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/30/22.
//

import UIKit

class SearchTypeCell: UITableViewCell {
	
	static let reuseId = String(describing: SearchTypeCell.self)
	
	var title: String = "" {
		didSet {
			titleLabel.text = title
		}
	}
	
	var saved: Bool = false {
		didSet {
			if saved {
				button.setImage(.checkmark, for: .normal)
			} else {
				button.setImage(.add, for: .normal)
			}
		}
	}

	
	let titleLabel = UILabel()
	let button = UIButton()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		configure()
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	func configure(for option: SearchOption) {
		self.title = option.name
		self.saved = option.isFavorite
	}
	
	
	@objc func buttonTapped(_ sender: UIButton) {
		print(#function)
	}
	
	private func configure() {
		
		//accessoryType = .detailDisclosureButton
		
		contentView.addSubview(titleLabel)
		contentView.addSubview(button)
		
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		button.translatesAutoresizingMaskIntoConstraints = false
		
		button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
		
		NSLayoutConstraint.activate([
			button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			button.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
			button.widthAnchor.constraint(equalTo: button.heightAnchor),
			button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			
			titleLabel.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 20),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			
		])
		
	}

}
