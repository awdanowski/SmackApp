//
//  ModalAddChannel.swift
//  SmackApp
//
//  Created by August Danowski on 10/2/17.
//  Copyright © 2017 Think Berkshire. All rights reserved.
//

import Cocoa

class ModalAddChannel: NSView {

	// Outlets
	
	@IBOutlet weak var view: NSView!
	
	@IBOutlet weak var channelNameText: NSTextField!
	@IBOutlet weak var channelDescriptionText: NSTextField!
	
	@IBOutlet weak var createChannelButton: NSButton!
	@IBOutlet weak var stackView: NSStackView!
	@IBOutlet weak var progressSpinner: NSProgressIndicator!
	
	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		
		Bundle.main.loadNibNamed(NSNib.Name(rawValue: "ModalAddChannel"), owner: self, topLevelObjects: nil)
		
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
	
	func setUpView() {
		
		self.view.frame = NSRect(x: 0, y: 0, width: 475, height: 300)
		
		view.layer?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		view.layer?.cornerRadius = 7
		
		createChannelButton.layer?.backgroundColor = chatGreen.cgColor
		createChannelButton.layer?.cornerRadius = 7
		createChannelButton.styleButtonText(button: createChannelButton, buttonName: "Create Channel", fontColor: .white, alignment: .center, font: AVENIR_REGULAR, size: 14.0)
		
	}
	
	@IBAction func closeButtonClicked(_ sender: Any) {
		
		NotificationCenter.default.post(name: NOTIFICATION_CLOSE_MODAL, object: nil)

	}
	
	@IBAction func channelEnterPressed(_ sender: Any) {
	
		createChannelButton.performClick(nil)

	}
	
	@IBAction func createButtonClicked(_ sender: Any) {
		
		progressSpinner.isHidden = false
		progressSpinner.startAnimation(nil)
		
		stackView.alphaValue = 0.4
		createChannelButton.isEnabled = false
		
		SocketService.instance.addChannel(channelName: channelNameText.stringValue, channelDescription: channelDescriptionText.stringValue) { (success) in
			if(success) {
				
				self.progressSpinner.stopAnimation(nil)
				self.progressSpinner.isHidden = true
				
				NotificationCenter.default.post(name: NOTIFICATION_CLOSE_MODAL, object: nil)

			} else {
				
				print("Something went wrong")
			}
		}
	}
}
