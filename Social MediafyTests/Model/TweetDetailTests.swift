//
//  TweetDetailTests.swift
//  Social MediafyTests
//
//  Created by Juan Pablo Martinez Ruiz on 09/05/24.
//

import XCTest
@testable import Social_Mediafy

final class TweetDetailTests: XCTestCase {
    func test_tweetDetailModel_correctDecodeResponse() throws {
        guard let path = Bundle(for: type(of: self)).path(forResource: "tweetDetailFake",
                                                          ofType: "json") else {
            fatalError("Couldn't find tweetDetailFake.json file")
        }

        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let sut = try JSONDecoder().decode(TweetDetail.self, from: data)

        XCTAssertEqual(sut.id, "id")
        XCTAssertEqual(sut.text, "This is an example")
        XCTAssertNotNil(sut.user)
        XCTAssertGreaterThan(sut.comments.count, 1)
    }
}
