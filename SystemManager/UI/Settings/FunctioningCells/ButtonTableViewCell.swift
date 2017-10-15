//
//  ButtonTableViewCell.swift
//  SystemManager
//
//  Created by Codetector on 14/10/2017.
//  Copyright © 2017 Guardian Tech. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    private var callback: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCallback(callback: @escaping () -> Void) {
        self.callback = callback
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            callback?()
        }
        // Configure the view for the selected state
    }
    
}
