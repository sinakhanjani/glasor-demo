//
//  DataManager.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/19/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import Foundation
class DataManager {
    
    static let shared = DataManager()
    
    var FCMToken = ""
    var courseId = ""
    
    var teacherId = ""
    var teacherCourse = ""
    var startMonth = ""
    var endMoth = ""
    
    public var userDatail: Login? { // user detail
        get {
            return Login.decode(directory: Login.archiveURL)
        }
        set {
            if let encode = newValue {
                Login.encode(save: encode, directory: Login.archiveURL)
            }
        }
    }
    
}
