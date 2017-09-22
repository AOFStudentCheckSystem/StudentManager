//
//  AuthAPI.swift
//  SystemManager
//
//  Created by Codetector on 2017/9/9.
//  Copyright © 2017年 Guardian Tech. All rights reserved.
//

import Foundation
import Alamofire

class AuthAPI {
    private static let AUTH_TOKEN_KEY:String = "AuthenticationToken"
    static let AUTH_TOKEN_CHANGE_NOTIFICATION = "AUTH_TOKEN_CHANGED"
    
    private weak var rootAPI: StudentCheckAPI?
    
    init (rootAPI:StudentCheckAPI) {
        self.rootAPI = rootAPI
    }
    
    var authenticationToken: String = UserDefaults.standard.string(forKey: AUTH_TOKEN_KEY) ?? "" {
        didSet {
            print("New Token: \(self.authenticationToken)")
            UserDefaults.standard.set(authenticationToken, forKey: AuthAPI.AUTH_TOKEN_KEY)
            NotificationCenter.default.post(name: Notification.Name.init(AuthAPI.AUTH_TOKEN_CHANGE_NOTIFICATION), object: nil)
        }
    }
    
    var isAuthenticated: Bool {
        get {
            return self.authenticationToken.count > 0
        }
    }
    
    func authenticate(email: String, password: String, completionHandler: ((_ result: Bool) -> Void)? = nil) {
        Alamofire.request((rootAPI!.baseUrl + "auth/auth"), method: .post, parameters: ["email":email, "password": password]).responseJSON { (response) in
            if response.result.isSuccess {
                if (response.value! is Dictionary<String, Any>) {
                    let token = (((response.value!) as! Dictionary<String, Any>)["token"] ?? "") as? String
                    self.authenticationToken = token ?? ""
                }
            }
            if completionHandler != nil {
                completionHandler!(response.result.isSuccess)
            }
        }
    }
}
