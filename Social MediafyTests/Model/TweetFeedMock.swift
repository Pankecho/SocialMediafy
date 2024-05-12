//
//  TweetFeedMock.swift
//  Social MediafyTests
//
//  Created by Juan Pablo Martinez Ruiz on 12/05/24.
//

import Foundation
@testable import Social_Mediafy

class TweetStub {
    func tweetStub() throws -> Tweet {
        guard let path = Bundle(for: type(of: self)).path(forResource: "tweetFeedFake",
                                                          ofType: "json") else {
            fatalError("Couldn't find tweetFeedFake.json file")
        }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        return try JSONDecoder().decode(Tweet.self, from: data)
    }
    
    func tweets(number: Int) throws -> [Tweet] {
        var timeline = [Tweet]()
        for _ in 1...number {
            timeline.append(try tweetStub())
        }
        return timeline
    }

    func tweetsData(number: Int) throws -> Data {
        let tweets = try tweets(number: number)
        return try JSONEncoder().encode(tweets)
    }

    func tweetData() throws -> Data {
        let tweet = try tweets(number: 1).first!
        return try JSONEncoder().encode(tweet)
    }
}
