//
//  PhotoCell.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/24/22.
//

import UIKit

class PhotoCell: UICollectionViewCell {
	
	static let reuseId = String(describing: PhotoCell.self)
	
	let imageView = UIImageView(frame: .zero)
	let spinner = UIActivityIndicatorView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	override func prepareForReuse() {
		super.prepareForReuse()
		imageView.image = nil
	}
	
	
	func update(displaying image: UIImage?) {
		if let image = image {
			spinner.stopAnimating()
			imageView.image = image
		} else {
			spinner.startAnimating()
			imageView.image = nil
		}
	}
	
	
	private func configure() {
		backgroundColor = .clear
		
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		addSubview(imageView)
		
		spinner.translatesAutoresizingMaskIntoConstraints = false
		spinner.style = .medium
		spinner.color = .white
		imageView.addSubview(spinner)
		
		let padding: CGFloat = 8
		
		NSLayoutConstraint.activate([
			imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
			imageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
			imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
			imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
			
			spinner.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
			spinner.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
		])
	}
}
