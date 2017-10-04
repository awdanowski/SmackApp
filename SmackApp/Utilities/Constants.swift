//
//  Constants.swift
//  SmackApp
//
//  Created by August Danowski on 9/26/17.
//  Copyright © 2017 Think Berkshire. All rights reserved.
//

import Cocoa

typealias CompletionHandler = (_ Success: Bool) -> ()

// URL Constants

let URL_BASE = "https://mychattychatapp.herokuapp.com/v1/"
let URL_REGISTER = "\(URL_BASE)account/register"
let URL_LOGIN = "\(URL_BASE)account/login"
let URL_USER_ADD = "\(URL_BASE)user/add"
let URL_GET_CHANNELS = "\(URL_BASE)channel"

let URL_USER_BY_EMAIL = "\(URL_BASE)/user/byEmail/"


// Colors

let chatPurple = NSColor(calibratedRed: 0.30, green: 0.22, blue: 0.29, alpha: 1.00)
let chatGreen = NSColor(calibratedRed: 0.22, green: 0.66, blue: 0.68, alpha: 1.00)

// Fonts

let AVENIR_REGULAR = "AvenirNext-Regular"
let AVENIR_BOLD = "AvenirNext-Bold"

// Notifications

let USER_INFO_MODAL = "modalUserInfo"
let USER_INFO_REMOVE_IMMEDIATELY = "modalRemoveImmediately"

let NOTIFICATION_PRESENT_MODAL = Notification.Name("presentModal")
let NOTIFICATION_CLOSE_MODAL = Notification.Name("closeModal")
let NOTIFICATION_USER_DATA_CHANGED = Notification.Name("userDataChanged")


// AuthServices

let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// Headers

let HEADER_STANDARD = ["Content-Type": "application/json; charset=utf-8"]
let HEADER_BEARER = ["Authorization": "Bearer \(AuthService.instance.authToken)", "Content-Type": "application/json; charset=utf-8"]

