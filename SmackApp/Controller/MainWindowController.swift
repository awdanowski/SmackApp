//
//  MainWindowController.swift
//  SmackApp
//
//  Created by August Danowski on 9/26/17.
//  Copyright © 2017 Think Berkshire. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
		
		window?.titlebarAppearsTransparent = true
		window?.titleVisibility = .hidden
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

}
