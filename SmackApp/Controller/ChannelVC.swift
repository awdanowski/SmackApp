//
//  ChannelVC.swift
//  SmackApp
//
//  Created by August Danowski on 9/26/17.
//  Copyright © 2017 Think Berkshire. All rights reserved.
//

import Cocoa

class ChannelVC: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.wantsLayer = true
		view.layer?.backgroundColor = chatPurple.cgColor
		
    }
    
}
