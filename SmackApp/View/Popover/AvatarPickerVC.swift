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
	
	var animalType = AnimalType.dark
	
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
	
	func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
		
		return NSMakeSize(85.0, 85.0)
	}
	
	func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
		
		let cell = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "AnimalCell"), for: indexPath)
		
		guard let animalCell = cell as? AnimalCell else { return NSCollectionViewItem() }
		animalCell.configureCell(index: indexPath.item, type: animalType)
		return cell
	}
	
	func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
		
		if let selectedIndexPath = collectionView.selectionIndexPaths.first {
			
			if animalType == .dark {
				UserDataService.instance.updateAvatar(name: "dark\(selectedIndexPath.item)", color: "")
			} else {
				UserDataService.instance.updateAvatar(name: "light\(selectedIndexPath.item)", color: "")
			}
			view.window?.cancelOperation(nil)
		}
		
	}
	
	// Actions
	
	@IBAction func segmentChanged(_ sender: Any) {
		if segmentControl.selectedSegment == 0 {
			animalType = .dark
		} else {
			animalType = .light
		}
		collectionView.reloadData()
	}
	
}
