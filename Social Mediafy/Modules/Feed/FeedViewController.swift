//
//  FeedViewController.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 13/05/24.
//

import UIKit

protocol FeedViewControllerDelegate: AnyObject {
    func routeToDetail(id: String)
}

final class FeedViewController: UIViewController {
    private var viewModel: TweetFeedViewModelProtocol
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TweetCell.self,
                           forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    weak var delegate: FeedViewControllerDelegate?
    
    init(viewModel: TweetFeedViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
        
        bindViewModel()
        
        viewModel.getTweets()
    }
    
    private func setup() {
        navigationItem.title = "Tweets"

        view.backgroundColor = .white
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.state.bind { state in
            guard let state = state else { return }
            switch state {
            case .success:
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            case .loading, .failure:
                break
            }
        }
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tweetCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                       for: indexPath) as? TweetCell,
              viewModel.tweetCount > 0 else {
            return .init()
        }

        let item = viewModel.getItem(at: indexPath.row)
        cell.configure(using: item)
        return cell
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.tweetCount > 0 else {
            return
        }
        
        let item = viewModel.getItem(at: indexPath.row)
        delegate?.routeToDetail(id: item.id)
    }
}
