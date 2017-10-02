//
//  AppDelegate.swift
//  SmackApp
//
//  Created by August Danowski on 9/26/17.
//  Copyright © 2017 Think Berkshire. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Insert code here to initialize your application
		
	}
	
	func applicationDidBecomeActive(_ notification: Notification) {
		SocketService.instance.establishConnection()
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
		
		SocketService.instance.closeConnection()
		
		// UserDataService.instance.logoutUser()
//		NotificationCenter.default.post(name: NOTIFICATION_USER_DATA_CHANGED, object: nil)

	}


}

