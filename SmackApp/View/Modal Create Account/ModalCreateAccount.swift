//
//  ModalCreateAccount.swift
//  SmackApp
//
//  Created by August Danowski on 9/27/17.
//  Copyright © 2017 Think Berkshire. All rights reserved.
//

import Cocoa

class ModalCreateAccount: NSView {

	// Outlets
	
	@IBOutlet weak var view: NSView!
	
	@IBOutlet weak var nameText: NSTextField!
	@IBOutlet weak var emailText: NSTextField!
	@IBOutlet weak var passwordText: NSSecureTextField!
	
	@IBOutlet weak var profileImage: NSImageView!
	
	@IBOutlet weak var createAccountButton: NSButton!
	@IBOutlet weak var chooseImageButton: NSButton!
	
	@IBOutlet weak var progressSpinner: NSProgressIndicator!
	
	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		
		Bundle.main.loadNibNamed(NSNib.Name(rawValue: "ModalCreateAccount"), owner: self, topLevelObjects: nil)
		
		addSubview(self.view)
		
	}
	
	required init?(coder decoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
	override func draw(_ dirtyRect: NSRect) {
		super.draw(dirtyRect)
		
		// Drawing code here.
		
		setUpView()
		
	}
	
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
				AuthService.instance.loginUser(email: self.emailText.stringValue, password: self.passwordText.stringValue, completion: {
					(success) in
					AuthService.instance.createAccount(name: self.nameText.stringValue, email: self.emailText.stringValue, avatarName: "", avatarColor: "", completion: {
						(success) in
						
						self.progressSpinner.stopAnimation(nil)
						self.progressSpinner.isHidden = true
						
						NotificationCenter.default.post(name: NOTIFICATION_CLOSE_MODAL, object: nil)
					})
				})
			}
		}
	}
	
	@IBAction func chooseAvatarClicked(_ sender: Any) {
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
}

