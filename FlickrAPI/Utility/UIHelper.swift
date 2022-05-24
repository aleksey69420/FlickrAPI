//
//  UIHelper.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/24/22.
//

import UIKit

struct UIHelper {
	
	static func createTwoColumnFlowLayout(view: UIView) -> UICollectionViewFlowLayout {
		
		let width = view.bounds.width
		let padding: CGFloat = 12
		let minItemSpacing: CGFloat = 5
		
		let availableWidth = width - padding * 2 - minItemSpacing * 2
		let itemWidth = availableWidth / 2
		
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
		flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
		return flowLayout
	}
}
