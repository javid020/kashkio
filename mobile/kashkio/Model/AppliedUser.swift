//
//  AppliedUser.swift
//  test
//
//  Created by Javid Abbasov on 04.07.2020.
//  Copyright © 2020 Javid Abbasov. All rights reserved.
//

import Foundation

struct AppliedUser: Codable {
    var id: Int?
    var waterRequest: WaterRequest?
    var appliedUser: User?
    var appliedDate: String?
    var closedDate: String?
    var status: String?
}
