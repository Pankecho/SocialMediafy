//
//  TweetViewModelTests.swift
//  Social MediafyTests
//
//  Created by Juan Pablo Martinez Ruiz on 12/05/24.
//

import XCTest
@testable import Social_Mediafy

final class TweetViewModelTests: XCTestCase {
    func testInitialState() throws {
        // Given
        let tweet = try TweetStub().tweetStub()
        
        // When
        let sut = TweetViewModel(item: tweet)
        
        // Then
        XCTAssertTrue(!sut.id.isEmpty)
        XCTAssertTrue(!sut.content.isEmpty)
        XCTAssertTrue(!sut.userName.isEmpty)
        XCTAssertTrue(!sut.nickName.isEmpty)
        XCTAssertTrue(!sut.commentCount.isEmpty)
        XCTAssertTrue(!sut.likeCount.isEmpty)
    }
}
