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
	
	func updateAvatarName(name: String = "") {
		
		self.avatarName = name
	}
	
	func updateAvatarColor(color: String = "") {
		
		self.avatarColor = color
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
	
	func returnCGColor(components: String) -> CGColor {
		
		let defaultColor = CGColor(red: 0.69, green: 0.85, blue: 0.99, alpha: 1.0)
		let comma = CharacterSet(charactersIn: ",")
		let skipped = CharacterSet(charactersIn: "][, ")

		let scanner = Scanner(string: components)
		scanner.charactersToBeSkipped = skipped
		
		var r, g, b, a : NSString?
		
		scanner.scanUpToCharacters(from: comma, into: &r)
		scanner.scanUpToCharacters(from: comma, into: &g)
		scanner.scanUpToCharacters(from: comma, into: &b)
		scanner.scanUpToCharacters(from: comma, into: &a)
		
		guard let rUnwrapped = r else { return defaultColor }
		guard let gUnwrapped = g else { return defaultColor }
		guard let bUnwrapped = b else { return defaultColor }
		guard let aUnwrapped = a else { return defaultColor }

		let rFloat = CGFloat(rUnwrapped.doubleValue)
		let gFloat = CGFloat(gUnwrapped.doubleValue)
		let bFloat = CGFloat(bUnwrapped.doubleValue)
		// let aFloat = CGFloat(aUnwrapped.doubleValue)

		return CGColor(red: rFloat, green: gFloat, blue: bFloat, alpha: 1.0)
	}
}
