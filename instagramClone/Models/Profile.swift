//
//  Profile.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/30/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import Foundation

struct Profile {
	
	let profileURL: String
	let username: String
	let imageData: Data
	
	init(dictonary: [String: Any], imageData: Data) {
		username = dictonary["username"] as? String ?? ""
		profileURL = dictonary["profileLink"] as? String ?? ""
		self.imageData = imageData
	}
}
