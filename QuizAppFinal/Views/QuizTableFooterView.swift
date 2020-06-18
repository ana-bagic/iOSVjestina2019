//
//  QuizTableFooterView.swift
//  QuizAppFinal
//
//  Created by five on 18/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import Foundation
import PureLayout

class QuizTableFooterView: UIView {
    
    var logoutButton: UIButton!
    
    @objc func logoutButtonTapped(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "token")
        userDefaults.removeObject(forKey: "user_id")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setRootLoginController()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.lightText
        
        logoutButton = UIButton()
        logoutButton.setTitle("Logout", for: UIControl.State.normal)
        logoutButton.titleLabel?.font = UIFont(name: "System Semibold", size: 18)
        logoutButton.backgroundColor = .systemBlue
        addSubview(logoutButton)
        
        logoutButton.autoAlignAxis(.vertical, toSameAxisOf: self)
        logoutButton.autoAlignAxis(.horizontal, toSameAxisOf: self)
        logoutButton.autoSetDimension(.height, toSize: 35)
        logoutButton.autoSetDimension(.width, toSize: 80)
        
        logoutButton.addTarget(self, action: #selector(QuizTableFooterView.logoutButtonTapped(_:)), for: UIControl.Event.touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
