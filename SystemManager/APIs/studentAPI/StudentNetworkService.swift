//
//  StudentNetworkService.swift
//  SystemManager
//
//  Created by Codetector on 2017/9/9.
//  Copyright © 2017年 Guardian Tech. All rights reserved.
//

import Foundation
import Siesta

class StudentNetworkService {
    init (rootService: StudentCheckNetwork) {
        self.rootService = rootService
    }
    
    private let rootService: StudentCheckNetwork
    
    var studentRoot: Resource {
        return rootService.resource("/student")
    }
    
    var allStudents: Resource {
        return studentRoot.child("/listall")
    }
}
