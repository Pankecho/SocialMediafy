//
//  TweetCommentViewModelTests.swift
//  Social MediafyTests
//
//  Created by Juan Pablo Martinez Ruiz on 12/05/24.
//

import XCTest
@testable import Social_Mediafy

final class TweetCommentViewModelTests: XCTestCase {
    func testInitialState() throws {
        // Given
        let tweet = try TweetDetailStub().tweetDetailStub()
        
        // When
        let sut = TweetCommentViewModel(item: tweet.comments.first!)
        
        // Then
        XCTAssertTrue(!sut.content.isEmpty)
        XCTAssertTrue(!sut.userName.isEmpty)
        XCTAssertTrue(!sut.nickName.isEmpty)
    }
}
