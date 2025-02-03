//
//  Week.swift
//  TEST
//
//  Created by Sinakhanjani on 9/2/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct WeekList: Codable {
    let toDo: [ToDo]
    
    enum CodingKeys: String, CodingKey {
        case toDo = "result"
    }
    
}

struct ToDo: Codable {
    let week, ringTitle, timeDo, courseID: String
    let courseTitle, fullName: String
    
    enum CodingKeys: String, CodingKey {
        case week
        case ringTitle = "ring_title"
        case timeDo = "time_do"
        case courseID = "course_id"
        case courseTitle = "course_title"
        case fullName = "full_name"
    }
}
