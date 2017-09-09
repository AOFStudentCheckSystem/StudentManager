//
//  AuthAPI.swift
//  SystemManager
//
//  Created by Codetector on 2017/9/9.
//  Copyright © 2017年 Guardian Tech. All rights reserved.
//

import Foundation

class AuthAPI {
    static let AUTH_TOKEN_KEY:String = "AuthenticationToken"
    static let AUTH_TOKEN_CHANGE_NOTIFICATION = "AUTH_TOKEN_CHANGED"
    
    var authenticationToken: String = UserDefaults.standard.string(forKey: AUTH_TOKEN_KEY) ?? "" {
        didSet {
            UserDefaults.standard.set(authenticationToken, forKey: AuthAPI.AUTH_TOKEN_KEY)
            NotificationCenter.default.post(name: Notification.Name.init(AuthAPI.AUTH_TOKEN_CHANGE_NOTIFICATION), object: nil)
        }
    }
    
    var isAuthenticated: Bool {
        get {
            return self.authenticationToken.count > 0
        }
    }
}
