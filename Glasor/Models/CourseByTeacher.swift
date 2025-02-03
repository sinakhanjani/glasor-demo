//
//  CourseByTeacher.swift
//  Glasor
//
//  Created by Teodik Abrami on 12/9/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import Foundation

struct CourseByTeacher: Codable {
    let course: [Course]
}

struct Course: Codable {
    let id, title: String
}
