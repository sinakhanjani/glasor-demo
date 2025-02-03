//
//  DataExtension.swift
//  TEST
//
//  Created by Sinakhanjani on 9/2/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

extension Data {
    static func createDataBody(withParameters parameters: FORMDATA_PARAMETERS, boundary: String) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
        for (key,value) in parameters {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
            body.append("\(value + lineBreak)")
        }
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
}


