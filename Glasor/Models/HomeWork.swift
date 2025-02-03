//
//  HomeWork.swift
//  TEST
//
//  Created by Sinakhanjani on 9/2/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct HomeWork: Codable {
    let work: [Work]
    
    enum CodingKeys: String, CodingKey {
        case work = "result"
    }
    
}

struct Work: Codable {
    let id, title, seen , description, attachment: String
    let day, cdate, expireCdate, dayTitle: String
    let typeDelivery, courseTitle: String
    let totalRow: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title, seen , description, attachment, day, cdate
        case expireCdate = "expire_cdate"
        case dayTitle = "day_title"
        case typeDelivery = "type_delivery"
        case courseTitle = "course_title"
        case totalRow = "total_row"
    }
}
