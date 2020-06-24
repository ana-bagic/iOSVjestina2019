//
//  LoginViewController.swift
//  QuizAppFinal
//
//  Created by five on 07/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var appNameLabel: UILabel!
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
                        
                        self.animateOut()
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
    
    func animateOut() {
        let translateY = -(UIScreen.main.bounds.height * 0.7)
        
        UIView.animate(withDuration: 1, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.appNameLabel.transform = CGAffineTransform(translationX: 0, y: translateY)
        })
        
        UIView.animate(withDuration: 1, delay: 0.1, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.usernameLabel.transform = CGAffineTransform(translationX: 0, y: translateY)
            self.usernameField.transform = CGAffineTransform(translationX: 0, y: translateY)
        })
        
        UIView.animate(withDuration: 1, delay: 0.2, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.passwordLabel.transform = CGAffineTransform(translationX: 0, y: translateY)
            self.passwordField.transform = CGAffineTransform(translationX: 0, y: translateY)
        })
        
        UIView.animate(withDuration: 1, delay: 0.3, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.loginButton.transform = CGAffineTransform(translationX: 0, y: translateY)
            self.errorLabel.transform = CGAffineTransform(translationX: 0, y: translateY)
        }, completion: {(finished:Bool) in
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.setRootTabBarController()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let translateX = -(UIScreen.main.bounds.width * 0.75)
        
        self.appNameLabel.alpha = 0
        self.usernameLabel.alpha = 0
        self.usernameField.alpha = 0
        self.passwordLabel.alpha = 0
        self.passwordField.alpha = 0
        self.loginButton.alpha = 0
        
        self.appNameLabel.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.usernameLabel.transform = CGAffineTransform(translationX: translateX, y: 0)
        self.usernameField.transform = CGAffineTransform(translationX: translateX, y: 0)
        self.passwordLabel.transform = CGAffineTransform(translationX: translateX, y: 0)
        self.passwordField.transform = CGAffineTransform(translationX: translateX, y: 0)
        self.loginButton.transform = CGAffineTransform(translationX: translateX, y: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.appNameLabel.alpha = 1
            self.appNameLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        
        UIView.animate(withDuration: 1, delay: 0.3, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.usernameLabel.alpha = 1
            self.usernameField.alpha = 1
            self.usernameLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            self.usernameField.transform = CGAffineTransform(translationX: 0, y: 0)
        })
        
        UIView.animate(withDuration: 1, delay: 0.6, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.passwordLabel.alpha = 1
            self.passwordField.alpha = 1
            self.passwordLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            self.passwordField.transform = CGAffineTransform(translationX: 0, y: 0)
        })
        
        UIView.animate(withDuration: 1, delay: 0.9, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.loginButton.alpha = 1
            self.loginButton.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.errorLabel.isHidden = true
        self.loginButton.backgroundColor = UIColor.FlatColor.Orange.Sun
        self.loginView.backgroundColor = UIColor.FlatColor.Blue.BlueWhale
        self.loginButton.layer.cornerRadius = 4
        self.appNameLabel.textColor = .white
        self.usernameLabel.textColor = .white
        self.passwordLabel.textColor = .white
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
