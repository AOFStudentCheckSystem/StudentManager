//
//  StudentAPI.swift
//  SystemManager
//
//  Created by Codetector on 2017/9/9.
//  Copyright © 2017年 Guardian Tech. All rights reserved.
//

import Foundation
import Alamofire

class StudentAPI {
    
    private weak var rootAPI: StudentCheckAPI?
    
    init(rootAPI: StudentCheckAPI) {
        self.rootAPI = rootAPI
    }
    
    func fetchAllStudents(completionHandler: @escaping (Array<Dictionary<String, Any>>?) -> Void) {

        Alamofire.request((rootAPI!.baseUrl + "student/listall"), method: .get, headers: rootAPI!.getStandardAuthorizationHeaders()).responseJSON { (response) in
            if response.result.isSuccess {
                guard let result = response.value as? Array<Dictionary<String, Any>> else {
                    completionHandler(nil)
                    return
                }
                completionHandler(result)
            } else {
                // Here is a failure handler
                completionHandler(nil)
            }
        }
    }
}
