//
//  GetExamClass.swift
//  Glasor
//
//  Created by Teodik Abrami on 4/10/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import Foundation

struct GetExamClass: Codable {
    let exam: [Exams]
}

struct Exams: Codable {
    let courseTitle, fullName, teacherCourse, teacherID: String
    let counter, counter1, classID: String
    
    enum CodingKeys: String, CodingKey {
        case courseTitle = "course_title"
        case fullName = "full_name"
        case teacherCourse = "teacher_course"
        case teacherID = "teacher_id"
        case counter, counter1
        case classID = "class_id"
    }
}
