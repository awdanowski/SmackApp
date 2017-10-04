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
	
	// Variables
	
	var selectedChannelIndex = 0
	var selectedChannel: Channel?
	var chatVC: ChatVC?
	
	// Functions
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
    }
	
	override func viewWillAppear() {
		setUpView()
		NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIFICATION_USER_DATA_CHANGED, object: nil)
	}
	
	override func viewDidAppear() {
		chatVC = self.view.window?.contentViewController?.childViewControllers[0].childViewControllers[1] as? ChatVC
	}
	
	func setUpView() {
		
		view.wantsLayer = true
		view.layer?.backgroundColor = chatPurple.cgColor
		
		addChannelButton.styleButtonText(button: addChannelButton, buttonName: "Add +", fontColor: .controlColor, alignment: .center, font: AVENIR_REGULAR, size: 13.0)
	}
	
	@objc func userDataDidChange(_ notification: Notification) {
		
		if AuthService.instance.isLoggedIn {
			userNameLabel.stringValue = UserDataService.instance.name
			getChannels()
		} else {
			userNameLabel.stringValue = ""
		}
		
	}
	
	func getChannels() {
		MessageService.instance.findAllChannels { (success) in
			if success {
				
				self.tableView.reloadData()
			}
		}

	}
	
	// Actions
	
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

extension ChannelVC: NSTableViewDelegate, NSTableViewDataSource {
	
	func numberOfRows(in tableView: NSTableView) -> Int {
		return MessageService.instance.channels.count
		
	}
	
	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		let channel = MessageService.instance.channels[row]
		
		if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "channelCell"), owner: nil) as? ChannelCell {
			
			cell.configureCell(channel: channel, selectedChannel: selectedChannelIndex, currentRow: row)
			return cell
			
		}
		return NSTableCellView()
	}
	
	func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
		return 35.0
	}
	
	func tableViewSelectionDidChange(_ notification: Notification) {
		selectedChannelIndex = tableView.selectedRow
		selectedChannel = MessageService.instance.channels[selectedChannelIndex]
		chatVC?.updateWithChannel(channel: selectedChannel!)

		tableView.reloadData()
		
	}
}
