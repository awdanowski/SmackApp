//
//  ChannelVC.swift
//  SmackApp
//
//  Created by August Danowski on 9/26/17.
//  Copyright © 2017 Think Berkshire. All rights reserved.
//

import Cocoa

class ChannelVC: NSViewController {

	// Outlets
	
	@IBOutlet weak var userNameLabel: NSTextField!
	@IBOutlet weak var addChannelButton: NSButton!
	@IBOutlet weak var tableView: NSTableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewWillAppear() {
		setUpView()
		NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIFICATION_USER_DATA_CHANGED, object: nil)
	}
	
	func setUpView() {
		
		view.wantsLayer = true
		view.layer?.backgroundColor = chatPurple.cgColor
		
		addChannelButton.styleButtonText(button: addChannelButton, buttonName: "Add +", fontColor: .controlColor, alignment: .center, font: AVENIR_REGULAR, size: 13.0)
	}
	
	@objc func userDataDidChange(_ notification: Notification) {
		
		if AuthService.instance.isLoggedIn {
			userNameLabel.stringValue = UserDataService.instance.name
		} else {
			userNameLabel.stringValue = ""
		}
		
	}
	
	@IBAction func addChannelClicked(_ sender: Any) {
		
		if AuthService.instance.isLoggedIn {

			let modalDictionary: [String: ModalType] = [USER_INFO_MODAL: ModalType.addChannel]
			NotificationCenter.default.post(name: NOTIFICATION_PRESENT_MODAL, object: nil, userInfo: modalDictionary)
			
		} else {
			let modalDictionary: [String: ModalType] = [USER_INFO_MODAL: ModalType.login]
			NotificationCenter.default.post(name: NOTIFICATION_PRESENT_MODAL, object: nil, userInfo: modalDictionary)
		}

	}
	
}
