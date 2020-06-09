//
//  LoginViewController.swift
//  QuizAppFinal
//
//  Created by five on 07/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func login(_ sender: Any) {
        loginUser()
    }
    
    func loginUser() {
        let loginService = LoginService()
        
        if let username = usernameField.text, let password = passwordField.text {
            loginService.login(username: username, password: password) { (json) in
                
                DispatchQueue.main.async {
                    if let jsonDict = json as? [String: Any],
                        let token = jsonDict["token"] as? String {
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(token, forKey: "token")
                        
                        let initialView = InitialViewController()
                        self.navigationController?.pushViewController(initialView, animated: true)
                    }
                }
            }
        }
        else {
            self.errorLabel.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.string(forKey: "token") != nil {
            let initialView = InitialViewController()
            self.navigationController?.pushViewController(initialView, animated: true)
        }
        
        self.errorLabel.isHidden = true
    }
}
