//
//  DailyItems.swift
//  Glasor
//
//  Created by Teodik Abrami on 12/10/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import Foundation

struct DailyItems: Codable {
    let result: [DailyItemsResult]
}

struct DailyItemsResult: Codable {
    let id, title, fullName, type: String
    let cdate: String
    let totalRow: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case fullName = "full_name"
        case type, cdate
        case totalRow = "total_row"
    }
}
