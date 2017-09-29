//
//  UserDataService.swift
//  SmackApp
//
//  Created by August Danowski on 9/28/17.
//  Copyright © 2017 Think Berkshire. All rights reserved.
//

import Foundation

class UserDataService {
	
	static let instance = UserDataService()
	
	private(set) var id = ""
	private(set) var avatarColor = ""
	private(set) var avatarName = ""
	private(set) var email = ""
	private(set) var name = ""

	func initialize(id: String, name: String, email: String, avatarName: String, avatarColor: String) {
	
		self.id = id
		self.name = name
		self.email = email
		self.avatarName = avatarName
		self.avatarColor = avatarColor
		
	}
	
	func logoutUser() {
		
		self.id = ""
		self.name = ""
		self.email = ""
		self.avatarName = ""
		self.avatarColor = ""

		AuthService.instance.authToken = ""
		AuthService.instance.userEmail = ""
		AuthService.instance.isLoggedIn = false
		
	}
}
