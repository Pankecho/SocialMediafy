//
//  Tweet.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 09/05/24.
//

import Foundation

protocol TweetProtocol {
    var id: String { get set }
    var text: String { get set }
    var user: User { get set }
}

struct TweetFeed: TweetProtocol, Codable {
    var id: String
    var text: String
    var user: User
    let likeCount: Int
    let commentCount: Int
}

extension TweetFeed {
    private enum CodingKeys: String, CodingKey {
        case id, text, user
        case likeCount = "like_count"
        case commentCount = "comment_count"
    }
}
