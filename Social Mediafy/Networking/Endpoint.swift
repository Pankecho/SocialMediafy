//
//  Endpoint.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 12/05/24.
//

import Foundation

enum Endpoint {
    // TODO: Change the baseURL
    static let baseURL = "https://wizetwitterproxy.herokuapp.com"
    
    case timeline
    case likeTweet(id: String)
    case commentTweet(id: String, comment: TweetComment)
}

extension Endpoint {
    var string: String {
        switch self {
        case .timeline:
            return "/api/tweet"
        case .likeTweet(let id):
            return "/api/tweet/\(id)/like"
        case .commentTweet(let id, _):
            return "/api/tweet/\(id)/comment"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: Endpoint.baseURL + string)!
        return URLRequest(url: url)
    }
}
