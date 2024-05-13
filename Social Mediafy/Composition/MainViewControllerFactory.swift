//
//  MainViewControllerFactory.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 13/05/24.
//

import Foundation
import UIKit

class iOSViewControllerFactory: ViewControllerFactory {
    func feedViewController() -> UIViewController {
        let viewModel = TweetFeedViewModel(provider: TweetAPI(session: .shared))
        return FeedViewController(viewModel: viewModel)
    }
    
    func detailViewController(id: String) -> UIViewController {
        let viewModel = TweetDetailViewModel(id: id, provider: TweetDetailAPI(session: .shared))
        return DetailViewController(viewModel: viewModel)
    }
}
