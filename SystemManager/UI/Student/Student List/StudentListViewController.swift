//
//  StudentListViewController.swift
//  SystemManager
//
//  Created by Codetector on 2017/9/9.
//  Copyright © 2017年 Guardian Tech. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class StudentListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    @IBOutlet var studentListTable: UITableView!
    
    let viewContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    lazy var fetchedResultController: NSFetchedResultsController<Student> = {
        let studentFetchRequest = NSFetchRequest<Student>(entityName: "Student")
        let lastNameSort = NSSortDescriptor(key: "lastName", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare))
        let firstNameSort = NSSortDescriptor(key: "firstName", ascending: true)
        studentFetchRequest.sortDescriptors = [lastNameSort, firstNameSort]
        
        let frc = NSFetchedResultsController(fetchRequest: studentFetchRequest,
                                             managedObjectContext: viewContext,
                                             sectionNameKeyPath: nil,
                                             cacheName: "STUDENT_TABLE_LIST_FRC_CACHE")
        frc.delegate = self
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.studentListTable.dataSource = self
        self.studentListTable.delegate = self

        CoreStudentCheck.shared.student.refresh { (magic) in
            print("Refresh complete: \(magic)")
        }
        
        do {
            try self.fetchedResultController.performFetch()
        } catch let error {
            print("Failed to fetch: \(error)")
        }
        self.studentListTable.reloadData()
        
//        StudentCheckAPI.shared.auth.authenticate(email: "codetector@codetector.cn", password: "J3pa2eqr") { result in
//            print("Done!")
//        }
        
        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.studentListTable {
            return self.fetchedResultController.sections!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.studentListTable {
            return (self.fetchedResultController.sections?[section].numberOfObjects)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath) as! StudentTableViewCell
        cell.student = self.fetchedResultController.object(at: indexPath)
        return cell
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
