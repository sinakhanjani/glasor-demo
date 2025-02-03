//
//  DayliItemsResult.swift
//  Glasor
//
//  Created by Teodik Abrami on 12/10/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import Foundation

struct DailyItemsDetail: Codable {
    let result: [DailyItemsDetailResult]
}

struct DailyItemsDetailResult: Codable {
    let id, teacherName, description, title: String
    let type, courseTitle, valueExtera, cdate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case teacherName = "teacher_name"
        case description, title, type
        case courseTitle = "course_title"
        case valueExtera = "value_extera"
        case cdate
    }
}
