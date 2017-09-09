//
//  AuthService.swift
//  SystemManager
//
//  Created by Codetector on 2017/9/9.
//  Copyright © 2017年 Guardian Tech. All rights reserved.
//

import Foundation
import Siesta

class AuthService {
    init (rootService: StudentCheckNetwork) {
        self.rootService = rootService
    }
    
    private let rootService: StudentCheckNetwork
    
    var authenticate: Resource {
        return rootService.resource("/auth/auth")
    }
}
