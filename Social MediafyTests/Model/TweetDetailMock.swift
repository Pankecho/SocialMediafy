//
//  TweetDetailMock.swift
//  Social MediafyTests
//
//  Created by Juan Pablo Martinez Ruiz on 12/05/24.
//

import Foundation
@testable import Social_Mediafy

class TweetDetailStub {
    func tweetDetailStub() throws -> TweetDetail {
        guard let path = Bundle(for: type(of: self)).path(forResource: "tweetDetailFake",
                                                          ofType: "json") else {
            fatalError("Couldn't find tweetDetailFake.json file")
        }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        return try JSONDecoder().decode(TweetDetail.self, from: data)
    }
    
    func tweetDetailData() throws -> Data {
        let tweet = try tweetDetailStub()
        return try JSONEncoder().encode(tweet)
    }
}
