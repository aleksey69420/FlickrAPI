//
//  SearchOptionCell.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/26/22.
//

import UIKit

class SearchOptionCell: UITableViewCell {
	
	static let reuseId = String(describing: SearchOptionCell.self)
	
	let iconImageView = UIImageView()
	let titleLabel = UILabel()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		configure()
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	private func configure() {
		
		accessoryType = .disclosureIndicator
		
		contentView.addSubview(iconImageView)
		contentView.addSubview(titleLabel)
		
		iconImageView.translatesAutoresizingMaskIntoConstraints = false
		iconImageView.contentMode = .scaleAspectFit
		
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		
		let padding: CGFloat = 12
		
		NSLayoutConstraint.activate([
			iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
			iconImageView.widthAnchor.constraint(equalToConstant: 60),
			iconImageView.heightAnchor.constraint(equalToConstant: 60),
			
			titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: padding * 2),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
			titleLabel.heightAnchor.constraint(equalToConstant: 40)
		])
	}
}
