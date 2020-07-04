//
//  WaterRequest.swift
//  test
//
//  Created by Javid Abbasov on 04.07.2020.
//  Copyright © 2020 Javid Abbasov. All rights reserved.
//

import Foundation

struct WaterRequest: Codable {
    var id: Int?
    var initator: User?
    
    var createdDate: String?
    var availTill: String?
    var latitude: Double?
    var longitude: Double?
    
    var requestType: Int?
    var additionalInfo: String?
}
