//
//  TweetFeedViewModelTests.swift
//  Social MediafyTests
//
//  Created by Juan Pablo Martinez Ruiz on 12/05/24.
//

import XCTest
@testable import Social_Mediafy

final class TweetFeedViewModelTests: XCTestCase {
    var sut: TweetFeedViewModelProtocol!
    var api: TweetAPI!
    var fakeSession: FakeSession!

    override func setUpWithError() throws {
        try super.setUpWithError()
        fakeSession = FakeSession()
        api = TweetAPI(session: fakeSession)
        sut = TweetFeedViewModel(provider: api)
    }

    override func tearDownWithError() throws {
        fakeSession = nil
        api = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testGetTweetsLoadingState() {
      // When
      sut.getTweets()
        
      // Then
      XCTAssertEqual(sut.state.value, .loading)
    }

    func testGetTweetsSuccessLoadingState() throws {
        // Given
        fakeSession.data = try TweetStub().tweetsData(number: 3)
        var changeState: Bool = false
        let expectation = expectation(description: "Fetched tweet timeline")
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
        sut.getTweets()

        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(changeState)
    }

    func testGetTweetsFailureLoadingState() throws {
        // Given
        fakeSession.data = try TweetStub().tweetData()
        var changeState: Bool = false
        let expectation = expectation(description: "Fetched tweet timeline")
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
        sut.getTweets()

        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(changeState)
    }

    func testGetTweetsSuccessData() throws {
        // Given
        fakeSession.data = try TweetStub().tweetsData(number: 3)
        let expectation = expectation(description: "Fetched tweet timeline")
        sut.state.bind { state in
          switch state {
          case .success:
            expectation.fulfill()
          default:
            break
          }
        }

        // When
        sut.getTweets()

        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(sut.tweetCount > 0)
    }
}
