//
//  ModalProfile.swift
//  SmackApp
//
//  Created by August Danowski on 9/29/17.
//  Copyright © 2017 Think Berkshire. All rights reserved.
//

import Cocoa

class ModalProfile: NSView {

	// Outlets
	
	@IBOutlet weak var view: NSView!
	
	@IBOutlet weak var nameLabel: NSTextField!
	@IBOutlet weak var emailLabel: NSTextField!
	@IBOutlet weak var avatarImage: NSImageView!
	
	@IBOutlet weak var logoutButton: NSButton!
	
	
	// Inits
	
	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		
		Bundle.main.loadNibNamed(NSNib.Name(rawValue: "ModalProfile"), owner: self, topLevelObjects: nil)
		
		addSubview(self.view)
		
	}
	
	required init?(coder decoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// Functions
	
	override func draw(_ dirtyRect: NSRect) {
		super.draw(dirtyRect)
		
		setUpView()
	}

	func setUpView() {
		
		self.view.frame = NSRect(x: 0, y: 0, width: 475, height: 300)
		
		nameLabel.stringValue = UserDataService.instance.name
		emailLabel.stringValue = UserDataService.instance.email
		
		view.layer?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		view.layer?.cornerRadius = 7
		
		logoutButton.layer?.backgroundColor = chatGreen.cgColor
		logoutButton.layer?.cornerRadius = 7
		logoutButton.styleButtonText(button: logoutButton, buttonName: "Logout", fontColor: .white, alignment: .center, font: AVENIR_BOLD, size: 14.0)
		
		avatarImage.layer?.cornerRadius = 10
		avatarImage.layer?.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
		avatarImage.layer?.borderWidth = 3
		avatarImage.layer?.backgroundColor = UserDataService.instance.returnCGColor(components: UserDataService.instance.avatarColor)
		avatarImage.image = NSImage(named: NSImage.Name(rawValue: UserDataService.instance.avatarName))
		
	}
	
	// Actions
	
	@IBAction func closeButtonClicked(_ sender: Any) {
		NotificationCenter.default.post(name: NOTIFICATION_CLOSE_MODAL, object: nil)
	}
	
	@IBAction func logoutButtonClicked(_ sender: Any) {
		
		print("Logout Button Pressed")
		UserDataService.instance.logoutUser()
		NotificationCenter.default.post(name: NOTIFICATION_USER_DATA_CHANGED, object: nil)
		NotificationCenter.default.post(name: NOTIFICATION_CLOSE_MODAL, object: nil)
		
	}
	
}
