//
//  MainCoordinator.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 13/05/24.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var rootViewController: UINavigationController
    var viewControllerFactory: ViewControllerFactory
    
    init(rootViewController: UINavigationController, 
         viewControllerFactory: ViewControllerFactory) {
        self.rootViewController = rootViewController
        self.viewControllerFactory = viewControllerFactory
    }
    
    func start() {
        guard let vc = viewControllerFactory.feedViewController() as? FeedViewController else { return }
        vc.delegate = self
        rootViewController.pushViewController(vc, animated: false)
    }
    
    func pushDetailViewController(id: String) {
        rootViewController.pushViewController(viewControllerFactory.detailViewController(id: id), animated: true)
    }
}


extension MainCoordinator: FeedViewControllerDelegate {
    func routeToDetail(id: String) {
        pushDetailViewController(id: id)
    }
}
