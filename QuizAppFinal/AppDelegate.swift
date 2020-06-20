//
//  AppDelegate.swift
//  QuizAppFinal
//
//  Created by five on 06/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let userDefaults = UserDefaults.standard
        if (userDefaults.string(forKey: "token") != nil) {
            setRootTabBarController()
        }
        else {
            setRootLoginController()
        }
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func setRootTabBarController() {
        
        let firstViewController = QuizzesViewController(viewModel: QuizzesViewModel())
        let navigationController1 = UINavigationController(rootViewController: firstViewController)
        navigationController1.tabBarItem = UITabBarItem(title: "Kvizovi", image: nil, selectedImage: nil)
        
        let secondViewController = SearchViewController(viewModel: QuizzesViewModel())
        let navigationController2 = UINavigationController(rootViewController: secondViewController)
        navigationController2.tabBarItem = UITabBarItem(title: "Pretraži", image: nil, selectedImage: nil)
        
        let thirdViewController = SettingsViewController()
        thirdViewController.tabBarItem = UITabBarItem(title: "Postavke", image: nil, selectedImage: nil)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [navigationController1, navigationController2, thirdViewController]
        
        let selected = [NSAttributedString.Key.foregroundColor: UIColor.FlatColor.Blue.BlueWhale, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        let normal = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        
        UITabBarItem.appearance().setTitleTextAttributes(normal as [NSAttributedString.Key : Any], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(selected as [NSAttributedString.Key : Any], for: .selected)
        
        let array = tabBarController.customizableViewControllers
        for controller in array! {
            controller.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -10)
        }
        
        window?.rootViewController = tabBarController
    }
    
    func setRootLoginController() {
        let viewController = LoginViewController()
        window?.rootViewController = viewController
    }

}

