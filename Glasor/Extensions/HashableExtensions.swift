//
//  HashableExtensions.swift
//  FerFere
//
//  Created by Teodik Abrami on 10/25/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import Foundation
import UIKit
extension Int {
    
    var seperateByCama: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let nsNumber = NSNumber(value: self)
        let number = formatter.string(from: nsNumber)!
        
        return number
    }
    
    
}

extension String {
    
    var seperateByCama: String {
        guard self != "0" && self != "" else { return "صفـر" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let nsNumber = NSNumber(value: Int(self)!)
        let number = formatter.string(from: nsNumber)!
        
        return number
    }
    
    
}


