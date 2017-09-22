//
//  StudentListViewController.swift
//  SystemManager
//
//  Created by Codetector on 2017/9/9.
//  Copyright © 2017年 Guardian Tech. All rights reserved.
//

import UIKit

class StudentListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        StudentCheckAPI.shared.auth.authenticate(email: "codetector@codetector.cn", password: "J3pa2eqr") { result in
//            print("Done!")
//        }
//
        StudentCheckAPI.shared.student.fetchAllStudents { (students) in
        
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
