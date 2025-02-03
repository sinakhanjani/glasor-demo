//
//  GetTableGroup.swift
//  Glasor
//
//  Created by Teodik Abrami on 4/10/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import Foundation

struct GetTableGroup: Codable {
    var better: [Better]
    let result: [TableGroupResult]
}

struct Better: Codable {
    let title: String
    let mark: String
    let markValue, typeMark: String
    
    enum CodingKeys: String, CodingKey {
        case title, mark
        case markValue = "mark_value"
        case typeMark = "type_mark"
    }
}

struct TableGroupResult: Codable {
    let id, averageBase, averageClass, courseTitle: String
    let grade, ratingBase, ratingClass, statusBase: String
    let statusClass: StatusClass
    
    enum CodingKeys: String, CodingKey {
        case id
        case averageBase = "average_base"
        case averageClass = "average_class"
        case courseTitle = "course_title"
        case grade
        case ratingBase = "rating_base"
        case ratingClass = "rating_class"
        case statusBase = "status_base"
        case statusClass = "status_class"
    }
}

enum StatusClass: Codable {
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
        throw DecodingError.typeMismatch(StatusClass.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for StatusClass"))
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

struct GetLoadMain: Codable {
    let baseYear, version: String
    
    enum CodingKeys: String, CodingKey {
        case baseYear = "base_year"
        case version
    }
}
