//
//  ExamList.swift
//  TEST
//
//  Created by Sinakhanjani on 9/2/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct Exam: Codable {
    let examList: [ExamList]
    
    enum CodingKeys: String, CodingKey {
        case examList = "result"
    }
    
}

struct ExamList: Codable {
    let id, timeDo, termID: String
    let fileExam: String
    let type, typeValue, teacherFullName, description: String
    let isTerm: Bool
    let courseTitle, day, dayTitle, date: String
    let cdate: String
    let totalRow: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case timeDo = "time_do"
        case termID = "term_id"
        case fileExam = "file_exam"
        case type
        case typeValue = "type_value"
        case teacherFullName = "teacher_full_name"
        case description
        case isTerm = "is_term"
        case courseTitle = "course_title"
        case day
        case dayTitle = "day_title"
        case date, cdate
        case totalRow = "total_row"
    }
}
