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
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		setUpView()
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
	
	@IBAction func sendMessageButtonClicked(_ sender: Any) {
	}
	
	
}
