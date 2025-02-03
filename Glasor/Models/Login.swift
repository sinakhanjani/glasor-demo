//
//  Login.swift
//  TEST
//
//  Created by Sinakhanjani on 9/2/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct Login: Codable {
    
    static public var archiveURL: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent("UserInfo").appendingPathExtension("gl")
    }
    
    let meliCode, studentID, tel, fName: String
    let lName, sex: String
    let logo: String
    let id, year, schoolID, classTitle: String
    let baseID, code, message, token: String
    
    enum CodingKeys: String, CodingKey {
        case meliCode = "meli_code"
        case studentID = "student_id"
        case tel
        case fName = "f_name"
        case lName = "l_name"
        case sex, logo, id, year
        case schoolID = "school_id"
        case classTitle = "class_title"
        case baseID = "base_id"
        case code, message, token
    }
    
    static func encode(save: Login, directory dir: URL) {
        let propertyListEncoder = PropertyListEncoder()
        if let encodedProduct = try? propertyListEncoder.encode(save) {
            try? encodedProduct.write(to: dir, options: .noFileProtection)
        }
    }
    
    static func decode(directory dir: URL) -> Login? {
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedProductData = try? Data.init(contentsOf: dir), let decodedProduct = try? propertyListDecoder.decode(Login.self, from: retrievedProductData) {
            return decodedProduct
        }
        return nil
    }
}
