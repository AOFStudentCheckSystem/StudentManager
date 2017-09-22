//
//  StudentCheckAPI.swift
//  SystemManager
//
//  Created by Codetector on 2017/9/9.
//  Copyright © 2017年 Guardian Tech. All rights reserved.
//

import Foundation
import Alamofire

class StudentCheckAPI {
    static let shared = StudentCheckAPI()
    
    let baseUrl: String = "https://api.aofactivities.com/"
    
    // konstancs
    static let kAuthenticationRequired = "AUTHENTICATION_REQUIRED_NOTIFICATION"
    static let kNetworkRequestFailed = "NETWORK_REQUEST_FAILED_NOTIFICATION"
    
    private init () {
        
    }
    
    func getStandardAuthorizationHeaders() -> HTTPHeaders? {
        if auth.isAuthenticated {
            return ["Authorization": auth.authenticationToken]
        } else {
            NotificationCenter.default.post(name: Notification.Name(StudentCheckAPI.kAuthenticationRequired), object: nil)
        }
        return nil
    }
    
    lazy var auth: AuthAPI = AuthAPI(rootAPI: self)
    lazy var student: StudentAPI = StudentAPI(rootAPI: self)
    
}
