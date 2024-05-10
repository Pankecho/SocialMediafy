//
//  TweetDetail.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 09/05/24.
//

import Foundation

struct TweetDetail: TweetProtocol, Codable {
    var id: String
    var text: String
    var user: User
    let comments: [TweetComment]
}

struct TweetComment: TweetProtocol, Codable {
    var id: String
    var text: String
    var user: User
}
