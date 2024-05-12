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
    
    func testNetworkResponse() {
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
    
    func testResponseWithError() {
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
