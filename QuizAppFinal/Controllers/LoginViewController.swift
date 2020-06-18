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
    @IBOutlet var loginView: UIView!
    
    @IBAction func login(_ sender: Any) {
        loginUser()
    }
    
    func loginUser() {
        let loginService = LoginService()
        
        if let username = usernameField.text, let password = passwordField.text {
            loginService.login(username: username, password: password) { (json) in
                
                DispatchQueue.main.async {
                    if let jsonDict = json as? [String: Any],
                        let token = jsonDict["token"] as? String,
                        let id = jsonDict["user_id"] as? Int {
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(token, forKey: "token")
                        userDefaults.set(id, forKey: "user_id")
                        userDefaults.set(username, forKey: "username")
                        
                        print(jsonDict)
                        
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.setRootTabBarController()
                    }
                    else {
                        self.errorLabel.isHidden = false
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
        self.errorLabel.isHidden = true
        //setupKeyboard()
    }
    
    /*
    func setupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardHeight = getKeyboardHeight(notification: notification) {
            loginView.frame.origin.y = -100
            //loginView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        if let keyboardHeight = getKeyboardHeight(notification: notification) {
            loginView.frame.origin.y = 0
            //loginView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat? {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            return keyboardHeight
        }
        return nil
    }
    */
}
