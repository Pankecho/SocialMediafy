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
    var comments: [TweetComment]
    
    static let empty = TweetDetail(id: "",
                                   text: "",
                                   user: .init(id: "",
                                               name: "",
                                               nickname: ""),
                                   comments: [])
}

struct TweetComment: TweetProtocol, Codable {
    var id: String
    var text: String
    var user: User
}

struct TweetCommentRequest: Codable {
    let text: String
}
