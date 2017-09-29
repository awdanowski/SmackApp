//
//  ModalLogin.swift
//  SmackApp
//
//  Created by August Danowski on 9/27/17.
//  Copyright © 2017 Think Berkshire. All rights reserved.
//

import Cocoa

class ModalLogin: NSView {

	// Outlets
	
	@IBOutlet weak var view: NSView!
	
	@IBOutlet weak var userNameText: NSTextField!
	@IBOutlet weak var passwordText: NSSecureTextField!
	@IBOutlet weak var loginButton: NSButton!
	@IBOutlet weak var createAccountButton: NSButton!
	@IBOutlet weak var stackView: NSStackView!
	
	@IBOutlet weak var progressSpinner: NSProgressIndicator!
	
	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		
		Bundle.main.loadNibNamed(NSNib.Name(rawValue: "ModalLogin"), owner: self, topLevelObjects: nil)
		
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
	
	@IBAction func enterPasswordSent(_ sender: Any) {
		loginButton.performClick(nil)
	}
		
	@IBAction func loginButtonClicked(_ sender: Any) {
		
		print("Login button pressed")
		
		progressSpinner.isHidden = false
		progressSpinner.startAnimation(nil)
		
		stackView.alphaValue = 0.4
		loginButton.isEnabled = false
		
		AuthService.instance.loginUser(email: userNameText.stringValue, password: passwordText.stringValue) {
			(loginsuccess) in
			if loginsuccess {
				print("login was successful")
				AuthService.instance.findUserByEmail(completion: {
					(findsuccess) in
					if findsuccess {
						print("find by email was successful")
						
						self.progressSpinner.stopAnimation(nil)
						self.progressSpinner.isHidden = true
						
						NotificationCenter.default.post(name: NOTIFICATION_CLOSE_MODAL, object: nil)
						NotificationCenter.default.post(name: NOTIFICATION_USER_DATA_CHANGED, object: nil)
						
					}
				})
			}
		}
	}
	
	@IBAction func createAccountButtonClicked(_ sender: Any) {
		
		let closeImmediatelyDict:[String: Bool] = [USER_INFO_REMOVE_IMMEDIATELY: true]
		NotificationCenter.default.post(name: NOTIFICATION_CLOSE_MODAL, object: nil, userInfo: closeImmediatelyDict)
		
		let createAccountDict:[String: ModalType] = [USER_INFO_MODAL: ModalType.createAccount]
		NotificationCenter.default.post(name: NOTIFICATION_PRESENT_MODAL, object: nil, userInfo: createAccountDict)
		
	}
	
	func setUpView() {
		
		self.view.frame = NSRect(x: 0, y: 0, width: 475, height: 300)

		view.layer?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		view.layer?.cornerRadius = 7
		
		loginButton.layer?.backgroundColor = chatGreen.cgColor
		loginButton.layer?.cornerRadius = 7
		loginButton.styleButtonText(button: loginButton, buttonName: "Login", fontColor: .white, alignment: .center, font: AVENIR_BOLD, size: 14.0)
		
		createAccountButton.styleButtonText(button: createAccountButton, buttonName: "Create account", fontColor: chatGreen, alignment: .center, font: AVENIR_REGULAR, size: 12.0)
	
	}
	
}
