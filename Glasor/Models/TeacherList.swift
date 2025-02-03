//
//  TeacherList.swift
//  TEST
//
//  Created by Sinakhanjani on 9/3/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation


struct TeacherList: Codable {
    let teachers: [Teacher]
    
    enum CodingKeys: String, CodingKey {
        case teachers = "result"
    }
}

struct Teacher: Codable {
    let fullName, teacherSchoolID: String
    let avatar: String
    let id: String?
    let courseTeacher: String
    let totalRow: Int
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case teacherSchoolID = "teacher_school_id"
        case avatar, id
        case courseTeacher = "course_teacher"
        case totalRow = "total_row"
    }
}
