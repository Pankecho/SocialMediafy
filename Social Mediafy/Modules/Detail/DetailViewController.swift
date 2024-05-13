//
//  DetailViewController.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 13/05/24.
//

import UIKit

final class DetailViewController: UIViewController {
    private var viewModel: TweetDetailViewModelProtocol
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(TweetCommentCell.self,
                           forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(viewModel: TweetDetailViewModelProtocol) {
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
        
        viewModel.getTweet()
    }
    
    private func setup() {
        navigationItem.title = "Comments"

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

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.commentCount
    }

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                   for: indexPath) as? TweetCommentCell,
          viewModel.commentCount > 0 else {
        return .init()
    }

    let item = viewModel.getComment(at: indexPath.row)
    cell.configure(using: item)
    return cell
}
}
