//
//  HonorResult.swift
//  TEST
//
//  Created by Sinakhanjani on 9/2/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct Honor: Codable {
    let honorResults: [HonorResult]
    
    enum CodingKeys: String, CodingKey {
        case honorResults = "result"
    }
}

struct HonorResult: Codable {
    let id, title: String
    let logo: String
    let action: String
    let totalRow: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title, logo, action
        case totalRow = "total_row"
    }
}
