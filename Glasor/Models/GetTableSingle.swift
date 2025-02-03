//
//  GetTableSingle.swift
//  Glasor
//
//  Created by Teodik Abrami on 4/10/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import Foundation

struct GetTableSingle: Codable {
    let result: [TableSingleResult]
}

struct TableSingleResult: Codable {
    let id, averageBase, averageClass, courseTitle: String
    let grade, ratingBase, ratingClass: String
    let statusBase: BaseStatus
    let statusClass: StatusClass1
    
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


enum StatusClass1: Codable {
    case double(Double)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
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
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}



enum BaseStatus: Codable {
    case double(Double)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
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
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
