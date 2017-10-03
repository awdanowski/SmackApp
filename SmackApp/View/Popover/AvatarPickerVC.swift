//
//  AvatarPickerVC.swift
//  SmackApp
//
//  Created by August Danowski on 10/3/17.
//  Copyright © 2017 Think Berkshire. All rights reserved.
//

import Cocoa

enum AnimalType {
	case dark
	case light
}

class AvatarPickerVC: NSViewController, NSCollectionViewDelegate, NSCollectionViewDataSource, NSCollectionViewDelegateFlowLayout {

	// Outlets
	
	@IBOutlet weak var segmentControl: NSSegmentedControl!
	@IBOutlet weak var collectionView: NSCollectionView!
	
	// Variables
	
	
	
	// Functions
	
	override func viewDidLoad() {
        super.viewDidLoad()

		collectionView.delegate = self
		collectionView.dataSource = self
		
	}
	
	func numberOfSections(in collectionView: NSCollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
		return 28
	}
	
	func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
		
		let cell = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "AnimalCell"), for: indexPath)
		
		return cell
	}
	
	func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
		
		return NSMakeSize(85.0, 85.0)
	}
}
