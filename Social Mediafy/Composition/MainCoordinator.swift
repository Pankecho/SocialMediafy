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
    
    func presentTweetCreationViewController() {
        let viewController = CreationViewController(viewModel: TweetCreationViewModel(id: "",
                                                                                      provider: PostCreationAPI(session: .shared)))
        rootViewController.present(UINavigationController(rootViewController: viewController), animated: true)
    }
    
    func pushDetailViewController(id: String) {
        guard let vc = viewControllerFactory.detailViewController(id: id) as? DetailViewController else { return }
        vc.delegate = self
        rootViewController.pushViewController(vc, animated: true)
    }
    
    func presentCommentCreationViewController(id: String) {
        let viewController = CreationViewController(viewModel: CommentCreationViewModel(id: "",
                                                                                        provider: CommentCreationAPI(session: .shared)))
        rootViewController.present(UINavigationController(rootViewController: viewController), animated: true)
    }
}

extension MainCoordinator: FeedViewControllerDelegate {
    func routeToDetail(id: String) {
        pushDetailViewController(id: id)
    }
    
    func routeToTweetCreation() {
        presentTweetCreationViewController()
    }
}

extension MainCoordinator: DetailViewControllerDelegate {
    func routeToCommentCreation(id: String) {
        presentCommentCreationViewController(id: id)
    }
}
