//
//  ExamResult.swift
//  TEST
//
//  Created by Sinakhanjani on 9/2/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct ExamResult: Codable {
    let result: [Result]
}

struct Result: Codable {
    let id, timeDo, description, type: String
    let typeValue: String
    let isTerm: Bool
    let mark: String
    let markValue, typeMark, termID: String
    let courseTitle, day, dayTitle, date: String
    let totalRow: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case timeDo = "time_do"
        case description, type
        case typeValue = "type_value"
        case isTerm = "is_term"
        case mark
        case markValue = "mark_value"
        case typeMark = "type_mark"
        case termID = "term_id"
        case courseTitle = "course_title"
        case day
        case dayTitle = "day_title"
        case date
        case totalRow = "total_row"
    }
}
