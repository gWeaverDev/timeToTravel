//
//  AppDelegate.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: Coordinatable?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navController = UINavigationController()
        appCoordinator = AppCoordinator(navigController: navController)
        appCoordinator?.start()
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }


}

