//
//  Main.swift
//  TEST
//
//  Created by Sinakhanjani on 9/2/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct Main: Codable {
    let day, month, schoolTitle: String
    let schoolLogo, schoolCover: String
    let newTitle, titleLimited, newsid: String
    let newsLogo: String
    let newsDate, newsVisit: String
    let notify: [Notify]
    let week: [Week]
    
    enum CodingKeys: String, CodingKey {
        case day, month
        case schoolTitle = "school_title"
        case schoolLogo = "school_logo"
        case schoolCover = "school_cover"
        case newTitle = "new_title"
        case titleLimited = "title_limited"
        case newsid = "news_id"
        case newsLogo = "news_logo"
        case newsDate = "news_date"
        case newsVisit = "news_visit"
        case notify, week
    }
}

// MARK: - Notify
struct Notify: Codable {
    let title, type: String
    let icon: String
    let counter: Counter
}

enum Counter: Codable {
    case integer(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Counter.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Counter"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Week
struct Week: Codable {
    let timeDo, schoolCourseTitle: String
    
    enum CodingKeys: String, CodingKey {
        case timeDo = "time_do"
        case schoolCourseTitle = "school_course_title"
    }
}
