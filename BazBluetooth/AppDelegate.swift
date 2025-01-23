//
//  AppDelegate.swift
//  BazBluetooth
//
//  Created by Usuario  on 19/08/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                     
            window = UIWindow(frame: UIScreen.main.bounds)
                   let vc = BLEBInitService()
                   let navigationController = UINavigationController(rootViewController: vc)
                   window?.rootViewController = navigationController
                   window?.makeKeyAndVisible()
            return true
        }

}
