//
//  GetExamTerms.swift
//  Glasor
//
//  Created by Teodik Abrami on 4/10/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import Foundation

struct GetExamTerm: Codable {
    let exam: [ExamTerms]
}

struct ExamTerms: Codable {
    let title, dateDo, termID: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case dateDo = "date_do"
        case termID = "term_id"
    }
}
