//
//  AppDelegate.swift
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/7.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ThemeModeManager.setup()
        TMTraitCollection.current = TMTraitCollection(userInterfaceStyle: .light, themeConfiguration: configuration)
        
        window = UIWindow()
        window?.rootViewController = {
          let tabBarController = UITabBarController()
          tabBarController.viewControllers = [
            NavigationController(rootViewController: MainViewController()),
            NavigationController(rootViewController: ViewController()),
          ]
          return tabBarController
        }()
        window?.makeKeyAndVisible()
        return true
    }

  
}

