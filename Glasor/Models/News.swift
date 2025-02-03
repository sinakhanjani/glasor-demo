//
//  News.swift
//  TEST
//
//  Created by Sinakhanjani on 9/2/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

struct NewsList: Codable {
    let news: [News]
    var album: [FORMDATA_PARAMETERS]
    
    enum CodingKeys: String, CodingKey {
        case news = "result"
        case album
    }
}

struct News: Codable {
    let id, type, visit, title: String
    let text: String
    let totalRow: Int
    let cdate: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id, type, visit, title, text
        case totalRow = "total_row"
        case cdate, image
    }
}
