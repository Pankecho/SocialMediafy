//
//  TweetAPITests.swift
//  Social MediafyTests
//
//  Created by Juan Pablo Martinez Ruiz on 12/05/24.
//

import XCTest
@testable import Social_Mediafy

final class TweetAPITests: XCTestCase {
    var sut: TweetAPIProtocol!
    private var session: FakeSession!
    
    override func setUp() {
        super.setUp()
        session = FakeSession()
        sut = TweetAPI(session: session)
    }
    
    func testNetworkResponse() {
        // given
        let expectation = expectation(description: "tweetfeed expectation")
        var response = false
        
        // when
        sut.load() { result in
            response = true
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(response)
    }
    
    func testResponseWithError() {
        // given
        let expectation = expectation(description: "tweetfeed expectation")
        var expectedError: TweetAPIError?
        session.error = TweetAPIError.response
        
        // when
        sut.load() { result in
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
    
    func testResponseWithNoData() throws {
        // given
        let expectation = expectation(description: "tweetfeed expectation")
        var expectedError: TweetAPIError?
        
        // when
        sut.load() { result in
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
    
    func testResponseWithParsingError() throws {
        // given
        let expectation = expectation(description: "tweetfeed expectation")
        var expectedError: TweetAPIError?
        session.data = Data()
        
        
        // when
        sut.load() { result in
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
    
    
    func testResponseWithParsing() throws {
        // given
        let expectation = expectation(description: "tweetfeed expectation")
        var timeline = [Tweet]()
        session.data = try TweetStub().tweetsData(number: 3)

        // when
        sut.load() { result in
            switch result {
            case .success(let tweets):
                timeline = tweets
                expectation.fulfill()
            default:
                break
            }
        }
        
        // then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(timeline.count, 3)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        session = nil
    }
}
