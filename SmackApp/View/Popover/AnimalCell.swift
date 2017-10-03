//
//  AnimalCell.swift
//  SmackApp
//
//  Created by August Danowski on 10/3/17.
//  Copyright © 2017 Think Berkshire. All rights reserved.
//

import Cocoa

class AnimalCell: NSCollectionViewItem {

	// Outlets
	
	@IBOutlet weak var animalImage: NSImageView!

	// Functions
	
	override func viewDidLoad() {
        super.viewDidLoad()
	}

	override func viewDidAppear() {
		setUpView()
	}
	
	func setUpView() {
	
		view.layer?.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		view.layer?.cornerRadius = 10
		view.layer?.borderWidth = 2
		view.layer?.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
	}
	
	func configureCell(index: Int, type: AnimalType) {
		if type == AnimalType.dark {
			animalImage.image = NSImage(named: NSImage.Name(rawValue: "dark\(index)"))
			view.layer?.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		} else {
			animalImage.image = NSImage(named: NSImage.Name(rawValue: "light\(index)"))
			view.layer?.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
		}
	}
	
	// Actions
	
	
}
