//
//  User.swift
//  test
//
//  Created by Javid Abbasov on 05.07.2020.
//  Copyright © 2020 Javid Abbasov. All rights reserved.
//

import Foundation

var currentUser: User?

struct User: Codable {
    var id: Int?
    var imageUrl: String?
    var login: String? // phone
    var password: String?
    var nickname: String?
    var latitude: Double?
    var longitude: Double?
    var points: Double?
    var badge: String?
}
