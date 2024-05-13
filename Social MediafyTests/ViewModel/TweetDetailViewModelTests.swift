//
//  TweetDetailViewModelTests.swift
//  Social MediafyTests
//
//  Created by Juan Pablo Martinez Ruiz on 12/05/24.
//

import XCTest
@testable import Social_Mediafy

final class TweetDetailViewModelTests: XCTestCase {
    var sut: TweetDetailViewModelProtocol!
    var api: TweetDetailAPIProtocol!
    var fakeSession: FakeSession!

    override func setUpWithError() throws {
        try super.setUpWithError()
        fakeSession = FakeSession()
        api = TweetDetailAPI(session: fakeSession)
        sut = TweetDetailViewModel(id: "id", provider: api)
    }

    override func tearDownWithError() throws {
        fakeSession = nil
        api = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testGetTweetDetailLoadingState() {
      // When
      sut.getTweet()
        
      // Then
      XCTAssertEqual(sut.state.value, .loading)
    }

    func testGetTweetDetailSuccessLoadingState() throws {
        // Given
        fakeSession.data = try TweetDetailStub().tweetDetailData()
        var changeState: Bool = false
        let expectation = expectation(description: "Fetched tweet detail")
        sut.state.bind { state in
          switch state {
          case .success:
            changeState = true
            expectation.fulfill()
          default:
            break
          }
        }

        // When
        sut.getTweet()

        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(changeState)
    }

    func testGetTweetDetailFailureLoadingState() throws {
        // Given
        fakeSession.data = try TweetStub().tweetData()
        var changeState: Bool = false
        let expectation = expectation(description: "Fetched tweet detail")
        sut.state.bind { state in
          switch state {
          case .failure:
            changeState = true
            expectation.fulfill()
          default:
            break
          }
        }

        // When
        sut.getTweet()

        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(changeState)
    }

    func testGetTweetDetailSuccessData() throws {
        // Given
        fakeSession.data = try TweetDetailStub().tweetDetailData()
        let expectation = expectation(description: "Fetched tweet detail")
        sut.state.bind { state in
          switch state {
          case .success:
            expectation.fulfill()
          default:
            break
          }
        }

        // When
        sut.getTweet()

        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(!sut.content.isEmpty)
        XCTAssertTrue(!sut.userName.isEmpty)
        XCTAssertTrue(!sut.nickName.isEmpty)
        XCTAssertTrue(sut.commentCount > 0)
    }
}
