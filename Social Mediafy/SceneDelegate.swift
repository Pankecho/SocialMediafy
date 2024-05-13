//
//  SceneDelegate.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 09/05/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: Coordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        coordinator = MainCoordinator(rootViewController: UINavigationController(),
                                      viewControllerFactory: iOSViewControllerFactory())
        coordinator.start()
        
        window?.rootViewController = coordinator.rootViewController
        window?.makeKeyAndVisible()
    }
}
