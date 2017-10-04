//
//  ChannelCell.swift
//  SmackApp
//
//  Created by August Danowski on 10/4/17.
//  Copyright © 2017 Think Berkshire. All rights reserved.
//

import Cocoa

class ChannelCell: NSTableCellView {

	// Outlets
	
	@IBOutlet weak var channelName: NSTextField!
	
	// Functions
	
	override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

     }
	
	func configureCell(channel: Channel, selectedChannel: Int, currentRow: Int) {
		
		let title = channel.myTitle ?? ""
		channelName.stringValue = "#\(title)"
		
		wantsLayer = true
		
		if currentRow == selectedChannel {
			layer?.backgroundColor = chatGreen.cgColor
			channelName.textColor = NSColor.white
		} else {
			layer?.backgroundColor = CGColor.clear
			channelName.textColor = NSColor.controlColor
		}
	}
}
