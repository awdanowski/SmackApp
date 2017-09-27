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
	
	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		
		Bundle.main.loadNibNamed(NSNib.Name(rawValue: "ModalLogin"), owner: self, topLevelObjects: nil)
		
		self.view.frame = NSRect(x: 0, y: 0, width: 475, height: 300)
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
		
		view.layer?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		view.layer?.cornerRadius = 7
		
	}
}
