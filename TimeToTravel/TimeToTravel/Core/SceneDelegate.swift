//
//  AppCoordinator.swift
//  TimeToTravel
//
//  Created by George Weaver on 02.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: Coordinatable?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        let appCoordinator = AppCoordinator()
        window?.rootViewController = appCoordinator.start()
        window?.makeKeyAndVisible()
    }
}

