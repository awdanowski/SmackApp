//
//  AuthService.swift
//  SmackApp
//
//  Created by August Danowski on 9/28/17.
//  Copyright © 2017 Think Berkshire. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
	
	static let instance = AuthService()
	
	let defaults = UserDefaults.standard
	
	var isLoggedIn: Bool {
		get {
			return defaults.bool(forKey: LOGGED_IN_KEY)
		}
		set {
			defaults.set(newValue, forKey: LOGGED_IN_KEY)
		}
	}
	
	var authToken: String {
		get {
			return defaults.value(forKey: TOKEN_KEY) as! String
		}
		set {
			defaults.set(newValue, forKey: TOKEN_KEY)
		}
	}

	var userEmail: String {
		get {
			return defaults.value(forKey: USER_EMAIL) as! String
		}
		set {
			defaults.set(newValue, forKey: USER_EMAIL)
		}
	}

	func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
		
		let email = email.lowercased()
		
		let body: [String: Any] = ["email": email, "password": password]
		
		Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: URL_HEADER).responseString {
			(response) in
				if response.result.error == nil {
					print("Response: \(response)")
					completion(true)
				} else {
					completion(false)
					debugPrint(response.result.error as Any)
				}
		}
	}
	
	func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
		
		let email = email.lowercased()
		
		let body: [String: Any] = ["email": email, "password": password]

		Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: URL_HEADER).responseJSON {
			(response) in
			if response.result.error == nil {
				
				guard let data = response.data else { return }
				
				let json = JSON(data: data)
				
				let user = json["user"].stringValue
				let token = json["token"].stringValue
				
				print("User: \(user)")
				print(token)
				
				self.userEmail = user
				self.authToken = token
				self.isLoggedIn = true
				
				completion(true)
				
			} else {
				completion(false)
				debugPrint(response.result.error as Any)
			}
		}
	}
	
	func createAccount(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
		
		let email = email.lowercased()
		
		let header = [
			"Authorization": "Bearer \(authToken)",
			"Content-Type": "application/json; charset=utf-8"
		]
		
		let body: [String: Any] = [
			"name": name,
			"email": email,
			"avatarName": avatarName,
			"avatarColor": avatarColor
		]

		Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON {
			(response) in
			if response.result.error == nil {
				
				guard let data = response.data else { return }
				
				let json = JSON(data: data)
				
				let id = json["_id"].stringValue
				let userName = json["name"].stringValue
				let email = json["email"].stringValue
				let avatarName = json["avatarName"].stringValue
				let avatarColor = json["avatarColor"].stringValue
				
				print("Name: \(userName)")
				
				UserDataService.instance.initialize(id: id, name: userName, email: email, avatarName: avatarName, avatarColor: avatarColor)
				
				completion(true)
				
			} else {
				completion(false)
				debugPrint(response.result.error as Any)
			}
		}
	}
}
