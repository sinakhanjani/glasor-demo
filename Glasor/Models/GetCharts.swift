//
//  GetCharts.swift
//  Glasor
//
//  Created by Teodik Abrami on 4/10/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import Foundation

struct GetCharts: Codable {
    let examShortcut: [ExamShortcut]
    let exam: [GetChartExam]
    
    enum CodingKeys: String, CodingKey {
        case examShortcut = "exam_shortcut"
        case exam
    }
}

struct GetChartExam: Codable {
    let mark, groupCount, examID, courseTitle: String
    let classTitle, notifyAssessmentClass, notifyAssessmentTerm, classID: String
    
    enum CodingKeys: String, CodingKey {
        case mark
        case groupCount = "group_count"
        case examID = "exam_id"
        case courseTitle = "course_title"
        case classTitle = "class_title"
        case notifyAssessmentClass = "notify_assessment_class"
        case notifyAssessmentTerm = "notify_assessment_term"
        case classID = "class_id"
    }
}

struct ExamShortcut: Codable {
    let id, title, isTerm, classID: String
    let teacherCourse, dateDo: String
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case isTerm = "is_term"
        case classID = "class_id"
        case teacherCourse = "teacher_course"
        case dateDo = "date_do"
    }
}
