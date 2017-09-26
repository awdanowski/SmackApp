//
//  NSButton.swift
//  Weatherd
//
//  Created by August Danowski on 9/26/17.
//  Copyright © 2017 Think Berkshire. All rights reserved.
//

import Foundation
import Cocoa

extension NSButton {
	
	func styleButtonText(button: NSButton, buttonName: String, fontColor: NSColor, alignment: NSTextAlignment, font: String, size: CGFloat) {
		
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = alignment
		
		button.attributedTitle = NSAttributedString(string: buttonName,
		                                            attributes: [NSAttributedStringKey.foregroundColor: fontColor,
		                                                         NSAttributedStringKey.paragraphStyle: paragraphStyle,
		                                                         NSAttributedStringKey.font: NSFont(name: font, size: size)])
		
	}
	
}
