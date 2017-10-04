//
//  MessageService.swift
//  SmackApp
//
//  Created by August Danowski on 10/3/17.
//  Copyright © 2017 Think Berkshire. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
	
	static let instance = MessageService()
	
	var channels = [Channel]()
	
	func findAllChannels(completion: @escaping CompletionHandler) {
		
		Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER_BEARER).responseJSON { (response) in
				
			if response.result.error == nil {
				guard let data = response.data else { return }
				if let json = JSON(data: data).array {
					for item in json {
						let channelName = item["name"].stringValue
						let channelDescription = item["description"].stringValue
						let channelID = item["_id"].stringValue
						
						let channel = Channel(myTitle: channelName, myDescription: channelDescription, myID: channelID)
						
						self.channels.append(channel)
						
					}
					completion(true)
				}
			} else {
				completion(false)
				print(response.result.error as Any)
			}
		}
	}
}
