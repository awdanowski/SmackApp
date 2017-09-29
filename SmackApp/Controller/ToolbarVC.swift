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
	case createAccount
	case profile
}

class ToolbarVC: NSViewController {

	// Outlets
	
	@IBOutlet weak var loginLabel: NSTextField!
	@IBOutlet weak var loginImage: NSImageView!
	@IBOutlet weak var loginStack: NSStackView!
	
	// Variables
	
	var modalBGView: ClickBlockingView!
	var modalView: NSView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewWillAppear() {
		setUpView()

	}
	
	func setUpView() {
		
		NotificationCenter.default.addObserver(self, selector: #selector(ToolbarVC.presentModal(_:)), name: NOTIFICATION_PRESENT_MODAL, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(ToolbarVC.closeModalNotification(_:)), name: NOTIFICATION_CLOSE_MODAL, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(ToolbarVC.userDataDidChange(_:)), name: NOTIFICATION_USER_DATA_CHANGED, object: nil)

		view.wantsLayer = true
		view.layer?.backgroundColor = chatGreen.cgColor

		loginStack.gestureRecognizers.removeAll()
		
		let profilePage = NSClickGestureRecognizer(target: self, action: #selector(ToolbarVC.openProfilePage))
		
		loginStack.addGestureRecognizer(profilePage)

	}
	
	@objc func openProfilePage(_ recognizer: NSClickGestureRecognizer) {
		
		let modalDictionary: [String: ModalType]
		
		if AuthService.instance.isLoggedIn {
			modalDictionary = [USER_INFO_MODAL: ModalType.profile]
		} else {
			modalDictionary = [USER_INFO_MODAL: ModalType.login]
		}
		
		NotificationCenter.default.post(name: NOTIFICATION_PRESENT_MODAL, object: nil, userInfo: modalDictionary)

	}
	
	@objc func presentModal(_ notification: Notification) {
		
		var modalWidth = CGFloat(0.0)
		var modalHeight = CGFloat(0.0)
		
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
			modalBGView.alphaValue = 0.0
			
			let closeBackgroundClick = NSClickGestureRecognizer(target: self, action: #selector(ToolbarVC.closeModalClick(_:)))
			
			modalBGView.addGestureRecognizer(closeBackgroundClick)
			
		}
		
		// Instantiate Modal XIB
		
		guard let modalType = notification.userInfo?[USER_INFO_MODAL] as? ModalType else { return }
		
		switch modalType {
			
		case ModalType.login:
			modalView = ModalLogin()
			modalWidth = 475
			modalHeight = 300
		case ModalType.createAccount:
			modalView = ModalCreateAccount()
			modalWidth = 475
			modalHeight = 300
		case ModalType.profile:
			modalView = ModalProfile()
			modalWidth = 475
			modalHeight = 300
		}
		
		modalView.wantsLayer = true
		modalView.translatesAutoresizingMaskIntoConstraints = false
		modalView.alphaValue = 0.0
		view.addSubview(modalView, positioned: .above, relativeTo: modalBGView)
		
		let horizontalConstraint = modalView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		let verticalConstraint = modalView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		let widthConstraint = modalView.widthAnchor.constraint(equalToConstant: modalWidth)
		let heightConstraint = modalView.heightAnchor.constraint(equalToConstant: modalHeight)
		
		NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])

		
		NSAnimationContext.runAnimationGroup({ (context) in
			
			context.duration = 0.5
			modalBGView.animator().alphaValue = 0.6
			modalView.animator().alphaValue = 1.0
			self.view.layoutSubtreeIfNeeded()
			
		}, completionHandler: nil)
		
	}
	
	@objc func closeModalNotification(_ notification: Notification) {
		if let removeImmediately = notification.userInfo?[USER_INFO_REMOVE_IMMEDIATELY] as? Bool {
			closeModal(removeImmediately)
		} else {
			closeModal()
		}
	}
	
	@objc func closeModalClick(_ recognizer: NSClickGestureRecognizer) {
		closeModal()
	}
	
	func closeModal(_ removeImmediately: Bool = false) {
		
		if removeImmediately {
			self.modalView.removeFromSuperview()
		} else {
			NSAnimationContext.runAnimationGroup({ (context) in
				
				context.duration = 0.5
				modalBGView.animator().alphaValue = 0.0
				modalView.animator().alphaValue = 0.0
				self.view.layoutSubtreeIfNeeded()
				
			}, completionHandler: {
				
				if self.modalBGView != nil {
					
					self.modalBGView.removeFromSuperview()
					self.modalBGView = nil
					
					self.modalView.removeFromSuperview()
					self.modalView = nil
					
				}
			})
		}
	}
	
	@objc func userDataDidChange(_ notification: Notification) {
		
		if AuthService.instance.isLoggedIn {

			loginLabel.stringValue = UserDataService.instance.name
			loginImage.wantsLayer = true
			loginImage.layer?.cornerRadius = 5
			loginImage.layer?.borderColor = CGColor.white
			loginImage.layer?.borderWidth = 1
			
			// ADD AVATAR COLOR
			
			loginImage.image = NSImage(named: NSImage.Name(rawValue: UserDataService.instance.avatarName))
			
		} else {
			loginLabel.stringValue = "Login"
			loginImage.wantsLayer = true
			loginImage.layer?.borderWidth = 0
			loginImage.layer?.backgroundColor = CGColor.clear
			loginImage.image = #imageLiteral(resourceName: "profileDefault")

		}
		
	}

}
