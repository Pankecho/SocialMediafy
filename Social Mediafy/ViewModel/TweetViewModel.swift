//
//  TweetViewModel.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 12/05/24.
//

import Foundation

protocol TweetViewModelProtocol {
    var content: String { get }
    var nickName: String { get }
    var userName: String { get }
    var likeCount: String { get }
    var commentCount: String { get }
    
    init(item: Tweet)
}

struct TweetViewModel: TweetViewModelProtocol {
    private let item: Tweet
    
    var content: String {
        return item.text
    }
    
    var nickName: String {
        return item.user.nickname
    }
    
    var userName: String {
        return item.user.name
    }
    
    var likeCount: String {
        return String(item.likeCount)
    }
    
    var commentCount: String {
        return String(item.commentCount)
    }
    
    init(item: Tweet) {
        self.item = item
    }
}

protocol TweetCommentViewModelProtocol {
    var content: String { get }
    var nickName: String { get }
    var userName: String { get }
    
    init(item: TweetComment)
}

struct TweetCommentViewModel: TweetCommentViewModelProtocol {
    private let item: TweetComment
    
    var content: String {
        return item.text
    }
    
    var nickName: String {
        return item.user.nickname
    }
    
    var userName: String {
        return item.user.name
    }
    
    init(item: TweetComment) {
        self.item = item
    }
}
