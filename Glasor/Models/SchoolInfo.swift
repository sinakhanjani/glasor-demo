//
//  SchoolInfo.swift
//  TEST
//
//  Created by Sinakhanjani on 9/2/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct SchoolInfo: Codable {
    let info: [Info]
    
    enum CodingKeys: String, CodingKey {
        case info = "result"
    }
}

struct Info: Codable {
    let id, tel, title, history: String
    let titleEarned, website: String
    let cover: String
    let telText, address: String
    
    enum CodingKeys: String, CodingKey {
        case id, tel, title, history
        case titleEarned = "title_earned"
        case website, cover
        case telText = "tel_text"
        case address
    }
}
