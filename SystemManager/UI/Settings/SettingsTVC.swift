//
//  SettingsTVC.swift
//  SystemManager
//
//  Created by Codetector on 14/10/2017.
//  Copyright © 2017 Guardian Tech. All rights reserved.
//

import UIKit
import StaticDataTableViewController
import Alertift

class SettingsTVC: StaticDataTableViewController {

    @IBOutlet weak var signInCell: ButtonTableViewCell!
    @IBOutlet weak var userStatusCell: UserStatusCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureAuthenticationSectionCells()
        NotificationCenter.default.addObserver(forName: Notification.Name("AUTH_TOKEN_CHANGED"), object: nil, queue: nil) { (_) in
            self.configureAuthenticationSectionCells()
        }
        // Setup SignIn Callback
        signInCell.setCallback {
            DispatchQueue.main.async {
                Alertift.alert(title: "Sign in", message: "Authenticate to enable more features")
                    .textField { textField in
                        textField.placeholder = "Username / Email"
                        textField.autocorrectionType = .no
                    }
                    .textField { textField in
                        textField.placeholder = "Password"
                        textField.isSecureTextEntry = true
                    }
                    .action(.cancel("Cancel"))
                    .action(.default("Sign in")) { _, _, textFields in
                        let id = textFields?.first?.text ?? ""
                        let password = textFields?.last?.text ?? ""
                        // sign in
                        
                        StudentCheckAPI.shared.auth.authenticate(email: id, password: password, completionHandler: { (result) in
                            print(result)
                        })
                        
                    }
                    .show()
            }
        }
    }
    
    private func configureAuthenticationSectionCells() {
        let authenticationStatus = StudentCheckAPI.shared.auth.isAuthenticated
        self.cell(signInCell, setHidden: authenticationStatus)
        self.cell(userStatusCell, setHidden: !authenticationStatus)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) else {
            print("Settings View: ERROR - Failed to cast cellClass")
            return
        }
        
        if cell.responds(to: Selector(("onClick"))) {
            cell.perform(Selector(("onClick")))
        } else {
            print("Settings View: INFO - Target cell does not respond to \"onClick()\" selector")
        }
    }
    
}
