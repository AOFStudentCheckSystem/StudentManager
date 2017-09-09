//
//  StudentCheckAPI.swift
//  SystemManager
//
//  Created by Codetector on 2017/9/9.
//  Copyright © 2017年 Guardian Tech. All rights reserved.
//

import Foundation
class StudentCheckAPI {
    static let shared = StudentCheckAPI()
    
    private init () {
        
    }
    lazy var rootNetworkAPI: StudentCheckNetwork = StudentCheckNetwork(api: self)
    
    lazy var auth: AuthAPI = AuthAPI(rootAPI: self)
    lazy var student: StudentAPI = StudentAPI()
    
}
