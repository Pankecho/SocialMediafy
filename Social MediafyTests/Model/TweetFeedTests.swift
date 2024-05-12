//
//  TweetFeedTests.swift
//  Social MediafyTests
//
//  Created by Juan Pablo Martinez Ruiz on 09/05/24.
//

import XCTest
@testable import Social_Mediafy

final class TweetFeedTests: XCTestCase {
    func test_tweetFeedModel_correctDecodeResponse() throws {
        guard let path = Bundle(for: type(of: self)).path(forResource: "tweetFeedFake",
                                                          ofType: "json") else {
            fatalError("Couldn't find tweetFeedFake.json file")
        }

        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let sut = try JSONDecoder().decode(Tweet.self, from: data)

        XCTAssertEqual(sut.id, "id")
        XCTAssertEqual(sut.text, "This is an example")
        XCTAssertEqual(sut.likeCount, 100)
        XCTAssertEqual(sut.commentCount, 10)
        XCTAssertNotNil(sut.user)
    }
}
