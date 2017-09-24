//
//  StudentTableViewCell.swift
//  SystemManager
//
//  Created by Codetector on 2017/9/9.
//  Copyright © 2017年 Guardian Tech. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var nickName: UILabel!
    var student: Student? {
        didSet {
            if student != nil {
                self.lastName.text = student?.lastName
                self.firstName.text = student?.firstName
                self.nickName.text = student?.preferredName
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
