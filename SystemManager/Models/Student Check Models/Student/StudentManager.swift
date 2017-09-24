//
//  Student.swift
//  SystemManager
//
//  Created by Codetector on 2017/9/22.
//  Copyright © 2017年 Guardian Tech. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class StudentManager {
    
    let kStudentRefreshNotification = "NOTIFICATION_STUDENT_REFRESH"
    
    func refresh(callback: ((Bool) -> Void)? = nil) {
        StudentCheckAPI.shared.student.fetchAllStudents { (data) in
            guard let appDelegate: AppDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let context = appDelegate.persistentContainer.newBackgroundContext()
            
            // Fetch all students in CoreData Storage
            do {
                var studentsFetchResult = try context.fetch(NSFetchRequest<Student>(entityName: "Student"))
                print("Student: Prepare for syncorization. Now local has \(studentsFetchResult.count) students")
                
                var removeList: Array<Student> = Array<Student>()
                
                studentsFetchResult.forEach({ (thisStudent) in
                    guard let searchResult = data?.first(where: { (it) -> Bool in
                        return it["idNumber"] as? String == thisStudent.idNumber
                    }) else {
                        removeList.append(thisStudent)
                        return
                    }
                    self.updateStudentWithJsonDictionary(student: thisStudent, dict: searchResult)
                })
                
                //Remove and refresh
                removeList.forEach({ (it) in
                    context.delete(it)
                })
                studentsFetchResult = try context.fetch(NSFetchRequest<Student>(entityName: "Student"))
                
                let studentEntityDescription = NSEntityDescription.entity(forEntityName: "Student", in: context)!
                data?.forEach({ (dict) in
                    guard let idNumber = dict["idNumber"] as? String else {
                        return
                    }
                    let searchResult = studentsFetchResult.first(where: { (student) -> Bool in
                        return student.idNumber == idNumber
                    })
                    if searchResult == nil {
                        let newStudent = Student(entity: studentEntityDescription, insertInto: context)
                        self.updateStudentWithJsonDictionary(student: newStudent, dict: dict, new: true)
                    }
                })
                
                NotificationCenter.default.post(name: Notification.Name(self.kStudentRefreshNotification), object: nil)
                studentsFetchResult = try context.fetch(NSFetchRequest<Student>(entityName: "Student"))
                
                if context.hasChanges {
                    try context.save()
                }
                
                print("Student: Syncorization Complete. Now local has \(studentsFetchResult.count) students")
                
                callback?(true)
            } catch let error {
                callback?(false)
                print("could not fetch \(error)")
            }
        }
    }
    
    func updateStudentWithJsonDictionary(student: Student, dict: Dictionary<String,Any>, new: Bool = false) {
        if (student.idNumber == dict["idNumber"] as? String || new) {
            if new {
                student.idNumber = dict["idNumber"] as? String
            }
            
            student.firstName = dict["firstName"] as? String
            student.lastName = dict["lastName"] as? String
            student.preferredName = dict["preferredName"] as? String
            student.cardSecret = dict["cardSecret"] as? String
            student.dorm = dict["dorm"] as? String
            student.email = dict["email"] as? String
            student.grade = dict["grade"] as! Int32
            student.studentType = dict["studentType"] as! Int16
        }
        print(student)
    }
    
}
