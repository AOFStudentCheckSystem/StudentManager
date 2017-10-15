//
//  Student+CoreDataClass.swift
//  SystemManager
//
//  Created by Codetector on 2017/9/9.
//  Copyright © 2017年 Guardian Tech. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Student)
public class Student: Saveable {
    @objc var upperCaseLastNameInitial:String {
        self.willAccessValue(forKey: "upperCaseLastNameInitial")
        let initial = String(self.lastName![..<self.lastName!.index(self.lastName!.startIndex, offsetBy: 1)]).uppercased()
        self.didAccessValue(forKey: "upperCaseLastNameInitial")
        return initial
    }
}
