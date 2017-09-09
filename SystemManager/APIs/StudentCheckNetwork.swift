//
//  StudentCheckNetwork.swift
//  SystemManager
//
//  Created by Codetector on 2017/9/9.
//  Copyright © 2017年 Guardian Tech. All rights reserved.
//

import Foundation
import Siesta

class StudentCheckNetwork: Service {
    weak var coreAPI: StudentCheckAPI?
    
    init (api: StudentCheckAPI) {
        self.coreAPI = api
        super.init(baseURL: "https://api.aofactivities.com")
        
        configure { (config) in
            config.headers["Authorization"] = self.coreAPI?.auth.authenticationToken ?? ""
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name.init(AuthAPI.AUTH_TOKEN_CHANGE_NOTIFICATION), object: nil, queue: OperationQueue.main) { (_) in
            self.invalidateConfiguration()
        }
    }
}
