//
//  SocketService.swift
//  SmackApp
//
//  Created by August Danowski on 9/30/17.
//  Copyright © 2017 Think Berkshire. All rights reserved.
//

import Cocoa
import SocketIO

class SocketService: NSObject {

	static let instance = SocketService()
	
	var socket: SocketIOClient = SocketIOClient(socketURL: URL(string: URL_BASE)!)
	
	override init() {
		super.init()
	}
	
	func establishConnection() {
		socket.connect()
	}
	
	func closeConnection() {
		socket.disconnect()
	}
	
	func addMessage(messageBody: String, userID: String, channelID: String, completion: @escaping CompletionHandler) {
		
		let user = UserDataService.instance
		
		socket.emit("newMessage", messageBody, userID, channelID, user.name, user.avatarName, user.avatarColor)
		completion(true)
		
	}
	
	func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
		
		socket.emit("newChannel", channelName, channelDescription)
		completion(true)
		
	}
}
