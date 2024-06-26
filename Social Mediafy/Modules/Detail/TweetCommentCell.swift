//
//  TweetCommentCell.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 13/05/24.
//

import UIKit

final class TweetCommentCell: UITableViewCell {
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView(image: .init(.user))
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .bold(withSize: .name)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nickNameLabel: UILabel = {
        let label = UILabel()
        label.font = .bold(withSize: .username)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .normal(withSize: .content)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        selectionStyle = .none
        backgroundColor = .systemBackground
    }
    
    private func layout() {
        contentView.addSubview(userImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(nickNameLabel)
        contentView.addSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            userImageView.widthAnchor.constraint(equalToConstant: 50),
            userImageView.heightAnchor.constraint(equalToConstant: 50),
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                               constant: 16),
            userImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                                constant: 16),
            
            nameLabel.bottomAnchor.constraint(equalTo: userImageView.centerYAnchor,
                                              constant: -2),
            nameLabel.leftAnchor.constraint(equalTo: userImageView.rightAnchor,
                                            constant: 8),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                             constant: -16),
            
            nickNameLabel.topAnchor.constraint(equalTo: userImageView.centerYAnchor,
                                               constant: 2),
            nickNameLabel.leftAnchor.constraint(equalTo: userImageView.rightAnchor,
                                                constant: 8),
            nickNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                                 constant: -16),
            
            contentLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor,
                                              constant: 16),
            contentLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                               constant: 16),
            contentLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                                constant: -16),
            contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                     constant: -16),
        ])
    }
    
    public func configure(using viewModel: TweetCommentViewModelProtocol) {
        nameLabel.text = viewModel.userName
        nickNameLabel.text = "@\(viewModel.nickName)"
        contentLabel.text = viewModel.content
    }
}
