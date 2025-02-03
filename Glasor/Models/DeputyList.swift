//
//  DeputyList.swift
//  TEST
//
//  Created by Sinakhanjani on 9/3/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct DeputyList: Codable {
    let deputys: [Deputy]
    
    enum CodingKeys: String, CodingKey {
        case deputys = "result"
    }
}

struct Deputy: Codable {
    let fullName, deputySchoolID: String?
    let avatar: String?
    let id, typeSelect: String?
    let totalRow: Int?
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case deputySchoolID = "deputy_school_id"
        case avatar, id
        case typeSelect = "type_select"
        case totalRow = "total_row"
    }
}
