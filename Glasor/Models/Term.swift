//
//  Term.swift
//  TEST
//
//  Created by Sinakhanjani on 9/2/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct TermList: Codable {
    let terms: [Term]
    
    enum CodingKeys: String, CodingKey {
        case terms = "result"
    }
    
}

struct Term: Codable {
    let id, termTitle, timeDo, fileExam: String
    let type, mark, typeMark, teacherFullName: String
    let description, courseTitle, day, dayTitle: String
    let date, cdate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case termTitle = "term_title"
        case timeDo = "time_do"
        case fileExam = "file_exam"
        case type, mark
        case typeMark = "type_mark"
        case teacherFullName = "teacher_full_name"
        case description
        case courseTitle = "course_title"
        case day
        case dayTitle = "day_title"
        case date, cdate
    }
}
