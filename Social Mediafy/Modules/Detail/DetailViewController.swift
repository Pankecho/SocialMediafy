//
//  DetailViewController.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 13/05/24.
//

import UIKit

final class DetailViewController: UIViewController {
    private let viewModel: TweetDetailViewModelProtocol
    
    init(viewModel: TweetDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
