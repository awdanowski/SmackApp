//
//  ToolbarVC.swift
//  SmackApp
//
//  Created by August Danowski on 9/26/17.
//  Copyright © 2017 Think Berkshire. All rights reserved.
//

import Cocoa

enum ModalType {
	case login
}

class ToolbarVC: NSViewController {

	// Outlets
	
	@IBOutlet weak var loginLabel: NSTextField!
	@IBOutlet weak var loginImage: NSImageView!
	@IBOutlet weak var loginStack: NSStackView!
	
	// Variables
	
	var modalBGView: ClickBlockingView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
    }
	
	override func viewWillAppear() {
		setUpView()
	}
	
	func setUpView() {
		
		NotificationCenter.default.addObserver(self, selector: #selector(ToolbarVC.presentModal), name: NOTIFICATION_PRESENT_MODAL, object: nil)
		
		view.wantsLayer = true
		view.layer?.backgroundColor = chatGreen.cgColor

		loginStack.gestureRecognizers.removeAll()
		
		let profilePage = NSClickGestureRecognizer(target: self, action: #selector(ToolbarVC.openProfilePage))
		
		loginStack.addGestureRecognizer(profilePage)

	}
	
	@objc func openProfilePage(_ recognizer: NSClickGestureRecognizer) {
		
		let loginDictionary: [String: ModalType] = [USER_INFO_MODAL: ModalType.login]
		NotificationCenter.default.post(name: NOTIFICATION_PRESENT_MODAL, object: nil, userInfo: loginDictionary)
	}
	
	@objc func presentModal(_ notification: Notification) {
		
		print("Present login modal")
		if modalBGView == nil {
			modalBGView = ClickBlockingView()
			modalBGView.translatesAutoresizingMaskIntoConstraints = false
			
			view.addSubview(modalBGView, positioned: .above, relativeTo: loginStack)
			
			let topConstraint = NSLayoutConstraint(item: modalBGView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 50)
			let leftConstraint = NSLayoutConstraint(item: modalBGView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
			let rightConstraint = NSLayoutConstraint(item: modalBGView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
			let bottomConstraint = NSLayoutConstraint(item: modalBGView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)

			view.addConstraints([topConstraint, leftConstraint, rightConstraint, bottomConstraint])
			
			modalBGView.layer?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
			modalBGView.alphaValue = 1.0
		}
		
		
		
	}
}
