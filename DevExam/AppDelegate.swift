//
//  AppDelegate.swift
//  DevExam
//
//  Created by Vlad Ralovich on 7.03.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SingInViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

