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
        
        let fontAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        
        window?.rootViewController = tabBarController
    }
    
    func setRootLoginController() {
        let viewController = LoginViewController()
        window?.rootViewController = viewController
    }

    // MARK: UISceneSession Lifecycle
    /*
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    */

}

