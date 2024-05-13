//
//  TweetDetailAPITests.swift
//  Social MediafyTests
//
//  Created by Juan Pablo Martinez Ruiz on 12/05/24.
//

import XCTest
@testable import Social_Mediafy

final class TweetDetailAPITests: XCTestCase {
    var sut: TweetDetailAPIProtocol!
    private var session: FakeSession!
    
    override func setUp() {
        super.setUp()
        session = FakeSession()
        sut = TweetDetailAPI(session: session)
    }
    
    func testGetTweetDetailNetworkResponse() {
        // given
        let expectation = expectation(description: "tweetdetail get expectation")
        var response = false
        
        // when
        sut.getTweet(id: "id") { result in
            response = true
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(response)
    }
    
    func testGetTweetDetailNetworkResponseWithError() {
        // given
        let expectation = expectation(description: "tweetdetail get expectation")
        var expectedError: TweetAPIError?
        session.error = TweetAPIError.response
        
        // when
        sut.getTweet(id: "id") { result in
            switch result {
            case .failure(let error):
                expectedError = error as? TweetAPIError
                expectation.fulfill()
            default:
                break
            }
        }
        
        // then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(expectedError)
    }
    
    func testGetTweetDetailNetworkResponseWithNoData() throws {
        // given
        let expectation = expectation(description: "tweetdetail get expectation")
        var expectedError: TweetAPIError?
        
        // when
        sut.getTweet(id: "id") { result in
            switch result {
            case .failure(let error):
                expectedError = error as? TweetAPIError
                expectation.fulfill()
            default:
                break
            }
        }
        
        // then
        wait(for: [expectation], timeout: 5.0)
        let unwrappedError = try XCTUnwrap(expectedError)
        XCTAssertEqual(unwrappedError, .noData)
    }
    
    func testGetTweetDetailNetworkResponseResponseWithParsingError() throws {
        // given
        let expectation = expectation(description: "tweetdetail get expectation")
        var expectedError: TweetAPIError?
        session.data = Data()
        
        
        // when
        sut.getTweet(id: "id") { result in
            switch result {
            case .failure(let error):
                expectedError = error as? TweetAPIError
                expectation.fulfill()
            default:
                break
            }
        }
        
        // then
        wait(for: [expectation], timeout: 5.0)
        let unwrappedError = try XCTUnwrap(expectedError)
        XCTAssertEqual(unwrappedError, .parsingData)
    }
    
    func testGetTweetDetailNetworkResponseWithParsing() throws {
        // given
        let expectation = expectation(description: "tweetfeed expectation")
        var tweet = TweetDetail.empty
        session.data = try TweetDetailStub().tweetDetailData()

        // when
        sut.getTweet(id: "id") { result in
            switch result {
            case .success(let tweetDetail):
                tweet = tweetDetail
                expectation.fulfill()
            default:
                break
            }
        }
        
        // then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(tweet.comments.count, 2)
    }
    
    func testCommentNetworkResponse() {
        // given
        let expectation = expectation(description: "tweetdetail comment expectation")
        var response = false
        
        // when
        sut.comment(id: "id", text: "Hola") { result in
            response = true
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(response)
    }
    
    func testCommentNetworkResponseWithError() {
        // given
        let expectation = expectation(description: "tweetdetail comment expectation")
        var expectedError: TweetAPIError?
        session.error = TweetAPIError.response
        
        // when
        sut.comment(id: "id", text: "Hola") { result in
            switch result {
            case .failure(let error):
                expectedError = error as? TweetAPIError
                expectation.fulfill()
            default:
                break
            }
        }
        
        // then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(expectedError)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        session = nil
    }
}
