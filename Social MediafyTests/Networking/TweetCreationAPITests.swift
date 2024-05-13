//
//  TweetCreationAPITests.swift
//  Social MediafyTests
//
//  Created by Juan Pablo Martinez Ruiz on 13/05/24.
//

import XCTest
@testable import Social_Mediafy

final class TweetCreationAPITests: XCTestCase {
    var sut: CreationAPIProtocol!
    private var session: FakeSession!
    
    override func setUp() {
        super.setUp()
        session = FakeSession()
        sut = PostCreationAPI(session: session)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        session = nil
    }
    
    func testTweetCreationNetworkResponse() {
        // given
        let expectation = expectation(description: "tweet creation expectation")
        var response = false
        
        // when
        sut.send(id: "", text: "text") { result in
            response = true
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(response)
    }
    
    func testTweetCreationNetworkResponseWithError() {
        // given
        let expectation = expectation(description: "tweet creation expectation")
        var expectedError: TweetAPIError?
        session.error = TweetAPIError.response
        
        // when
        sut.send(id: "", text: "text") { result in
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
}
