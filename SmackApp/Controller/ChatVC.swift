//
//  ChatVC.swift
//  SmackApp
//
//  Created by August Danowski on 9/26/17.
//  Copyright © 2017 Think Berkshire. All rights reserved.
//

import Cocoa

class ChatVC: NSViewController {

	// Outlets
	
	@IBOutlet weak var channelTitle: NSTextField!
	@IBOutlet weak var channelDescription: NSTextField!
	@IBOutlet weak var tableView: NSTableView!
	@IBOutlet weak var typingUsersLabel: NSTextField!
	@IBOutlet weak var messageOutlineView: NSView!
	@IBOutlet weak var messageText: NSTextField!
	@IBOutlet weak var sendMessageButton: NSButton!
	
	// Variables
	
	let user = UserDataService.instance
	
	// Functions
	
    override func viewDidLoad() {
        super.viewDidLoad()
	}
	
	override func viewWillAppear() {
		setUpView()
		NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIFICATION_USER_DATA_CHANGED, object: nil)

	}
	
	func setUpView() {
		
		view.wantsLayer = true
		view.layer?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		
		messageOutlineView.wantsLayer = true
		messageOutlineView.layer?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		messageOutlineView.layer?.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
		messageOutlineView.layer?.borderWidth = 2
		messageOutlineView.layer?.cornerRadius = 5
		
		sendMessageButton.styleButtonText(button: sendMessageButton, buttonName: "Send", fontColor: .darkGray, alignment: .center, font: AVENIR_REGULAR, size: 13.0)
		
	}
	
	@objc func userDataDidChange(_ notification: Notification) {
		
		if AuthService.instance.isLoggedIn {
			channelTitle.stringValue = "#general"
			channelDescription.stringValue = "this is where the magic happens"
		} else {
			channelTitle.stringValue = "Please Log In"
			channelDescription.stringValue = ""
		}
		
	}
	
	func updateWithChannel(channel: Channel) {
		
		typingUsersLabel.stringValue = ""
		
		let name = channel.myTitle ?? ""
		let descriptionText = channel.myDescription ?? ""
		
		self.channelTitle.stringValue = name
		self.channelDescription.stringValue = descriptionText
	}

	// Actions
	
	@IBAction func sendMessageButtonClicked(_ sender: Any) {
		if AuthService.instance.isLoggedIn {
			
			let channelID = "592cd40e39179c0023f3531f"
			SocketService.instance.addMessage(messageBody: messageText.stringValue, userID: user.id, channelID: channelID, completion: { (success) in
				if success {
					self.messageText.stringValue = ""
				} 
			})
			
			
		} else {
			
			let modalDictionary: [String: ModalType] = [USER_INFO_MODAL: ModalType.login]
			NotificationCenter.default.post(name: NOTIFICATION_PRESENT_MODAL, object: nil, userInfo: modalDictionary)
			
		}
	}
}
