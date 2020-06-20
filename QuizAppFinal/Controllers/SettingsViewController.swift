//
//  SettingsViewController.swift
//  QuizAppFinal
//
//  Created by five on 18/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBAction func logoutClicked(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "token")
        userDefaults.removeObject(forKey: "user_id")
        userDefaults.removeObject(forKey: "username")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setRootLoginController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutButton.layer.cornerRadius = 4
        logoutButton.backgroundColor = UIColor.FlatColor.Blue.BlueWhale
        
        let userDefaults = UserDefaults.standard
        if let username = userDefaults.string(forKey: "username") {
            usernameLabel.text = "Username: " + username
        }
    }
}
