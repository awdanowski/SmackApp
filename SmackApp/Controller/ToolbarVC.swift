//
//  ToolbarVC.swift
//  SmackApp
//
//  Created by August Danowski on 9/26/17.
//  Copyright © 2017 Think Berkshire. All rights reserved.
//

import Cocoa

class ToolbarVC: NSViewController {

	// Outlets
	
	@IBOutlet weak var loginLabel: NSTextField!
	@IBOutlet weak var loginImage: NSImageView!
	@IBOutlet weak var loginStack: NSStackView!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
    }
	
	override func viewWillAppear() {
		setUpView()
	}
	
	func setUpView() {
		
		view.wantsLayer = true
		view.layer?.backgroundColor = chatGreen.cgColor

		loginStack.gestureRecognizers.removeAll()
		
		let profilePage = NSClickGestureRecognizer(target: self, action: #selector(ToolbarVC.openProfilePage))
		
		loginStack.addGestureRecognizer(profilePage)

	}
	
	@objc func openProfilePage(_ recognizer: NSClickGestureRecognizer) {
		
		print("Open profile page")
	}
}
