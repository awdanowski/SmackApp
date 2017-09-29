//
//  FormattedTextField.swift
//  SmackApp
//
//  Created by August Danowski on 9/29/17.
//  Copyright © 2017 Think Berkshire. All rights reserved.
//

import Cocoa

@IBDesignable
class FormattedTextField: NSTextField {
	
	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
	
	override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
	
	func setupView() {
		textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		font = NSFont(name: AVENIR_BOLD, size: 18)
	}
}
