//
//  Authentication.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/19/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import Foundation

class Authentication {
    
    static let auth = Authentication()
    
    let defaults = UserDefaults(suiteName: USER_DEFAULT_KEY)!
    
    
    private var _isLoggedIn: Bool {
        get {
            return defaults.value(forKey: IS_LOGGED_IN_KEY) as? Bool ?? false
        }
        set {
            defaults.set(newValue, forKey: IS_LOGGED_IN_KEY)
        }
    }
    
    public var isLoggedIn: Bool {
        return _isLoggedIn
    }
    
    public func authenticationUser(isLoggedIn: Bool, userInfo: Login?) {
        self._isLoggedIn = isLoggedIn
        DataManager.shared.userDatail = userInfo
    }
    
}

