//
//  ModalCreateAccount.swift
//  SmackApp
//
//  Created by August Danowski on 9/27/17.
//  Copyright © 2017 Think Berkshire. All rights reserved.
//

import Cocoa

class ModalCreateAccount: NSView, NSPopoverDelegate {

	// Outlets
	
	@IBOutlet weak var view: NSView!
	
	@IBOutlet weak var nameText: NSTextField!
	@IBOutlet weak var emailText: NSTextField!
	@IBOutlet weak var passwordText: NSSecureTextField!
	
	@IBOutlet weak var profileImage: NSImageView!
	
	@IBOutlet weak var createAccountButton: NSButton!
	@IBOutlet weak var chooseImageButton: NSButton!
	
	@IBOutlet weak var progressSpinner: NSProgressIndicator!
	
	// Variables
	
	var avatarName = "profileDefault"
	var avatarColor = "[0.5, 0.5, 0.5, 1.0]"
	
	let popOver = NSPopover()
	
	// Inits
	
	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		
		Bundle.main.loadNibNamed(NSNib.Name(rawValue: "ModalCreateAccount"), owner: self, topLevelObjects: nil)
		
		addSubview(self.view)
		popOver.delegate = self
		
	}
	
	required init?(coder decoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// Functions
	
	override func draw(_ dirtyRect: NSRect) {
		super.draw(dirtyRect)
		
		// Drawing code here.
		
		setUpView()
		
	}
	
	func setUpView() {
		
		self.view.frame = NSRect(x: 0, y: 0, width: 475, height: 300)
		
		view.layer?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		view.layer?.cornerRadius = 7
		
		profileImage.layer?.cornerRadius = 10
		profileImage.layer?.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		profileImage.layer?.borderWidth = 3
		
		createAccountButton.layer?.backgroundColor = chatGreen.cgColor
		createAccountButton.layer?.cornerRadius = 7
		createAccountButton.styleButtonText(button: createAccountButton, buttonName: "Create Account", fontColor: .white, alignment: .center, font: AVENIR_REGULAR, size: 14.0)
		
		chooseImageButton.layer?.backgroundColor = chatGreen.cgColor
		chooseImageButton.layer?.cornerRadius = 7
		chooseImageButton.styleButtonText(button: chooseImageButton, buttonName: "Choose Avatar", fontColor: .white, alignment: .center, font: AVENIR_REGULAR, size: 14.0)
		
	}
	
	func popoverDidClose(_ notification: Notification) {
		if UserDataService.instance.avatarName != "" {
			profileImage.image = NSImage(named: NSImage.Name(rawValue: UserDataService.instance.avatarName))
			
			avatarName = UserDataService.instance.avatarName
		}
	}
	
	// Actions
	
	@IBAction func closeModalClicked(_ sender: Any) {
		
		NotificationCenter.default.post(name: NOTIFICATION_CLOSE_MODAL, object: nil)

	}
	
	@IBAction func createAccountClicked(_ sender: Any) {
	
		progressSpinner.isHidden = false
		progressSpinner.startAnimation(nil)
		
//		stackView.alphaValue = 0.4
		createAccountButton.isEnabled = false

		AuthService.instance.registerUser(email: emailText.stringValue, password: passwordText.stringValue) {
			(success) in
			if success {
				print("Registered User")
				AuthService.instance.loginUser(email: self.emailText.stringValue, password: self.passwordText.stringValue, completion: {
					(success) in
					print("Logged In User")
					AuthService.instance.createAccount(name: self.nameText.stringValue, email: self.emailText.stringValue, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: {
						(success) in
						print("Created Account")
						
						self.progressSpinner.stopAnimation(nil)
						self.progressSpinner.isHidden = true
						
						NotificationCenter.default.post(name: NOTIFICATION_USER_DATA_CHANGED, object: nil)
						NotificationCenter.default.post(name: NOTIFICATION_CLOSE_MODAL, object: nil)
					})
				})
			}
		}
	}
	
	@IBAction func chooseAvatarClicked(_ sender: Any) {
		popOver.contentViewController = AvatarPickerVC(nibName: NSNib.Name(rawValue: "AvatarPickerVC"), bundle: nil)
		popOver.show(relativeTo: chooseImageButton.bounds, of: chooseImageButton, preferredEdge: .minX)
		popOver.behavior = .transient
	}
	
	
}

