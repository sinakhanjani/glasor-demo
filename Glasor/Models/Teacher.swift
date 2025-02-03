//
//  Teacher.swift
//  Glasor
//
//  Created by Teodik Abrami on 12/9/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import Foundation
struct DailyTeachers: Codable {
    let teacher: [DailyTeacher]
}

struct DailyTeacher: Codable {
    let teacherID, fullName: String
    
    enum CodingKeys: String, CodingKey {
        case teacherID = "teacher_id"
        case fullName = "full_name"
    }
}
