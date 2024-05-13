//
//  Endpoint.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 12/05/24.
//

import Foundation

enum Endpoint {
    static let baseURL = "https://run.mocky.io/v3"
    
    case timeline
    case getTweet(id: String)
    case likeTweet(id: String)
    case postTweet(text: String)
    case commentTweet(id: String, comment: String)
}

extension Endpoint {
    var string: String {
        switch self {
        case .timeline:
            return "/8dfa01c8-68c3-486b-b566-e0668b587101"
        case .getTweet(_):
            return "/a8dc2e18-372e-4395-90e4-b1990ac1da5e"
        case .postTweet(_):
            return "/api/tweet"
        case .likeTweet(let id):
            return "/api/tweet/\(id)/like"
        case .commentTweet(let id, _):
            return "/api/tweet/\(id)/comment"
        }
    }
    
    var request: URLRequest {
        switch self {
        case .timeline, .getTweet(_):
            let url = URL(string: Endpoint.baseURL + string)!
            return URLRequest(url: url)
        case .likeTweet(_):
            let url = URL(string: Endpoint.baseURL + string)!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            return request
        case .commentTweet(_, let comment):
            let url = URL(string: Endpoint.baseURL + string)!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let data = try? JSONEncoder().encode(CreationRequest(text: comment))
            request.httpBody = data
            return request
        case .postTweet(let text):
            let url = URL(string: Endpoint.baseURL + string)!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let data = try? JSONEncoder().encode(CreationRequest(text: text))
            request.httpBody = data
            return request
        }
    }
}
