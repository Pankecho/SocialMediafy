//
//  TweetCreationViewModelTests.swift
//  Social MediafyTests
//
//  Created by Juan Pablo Martinez Ruiz on 13/05/24.
//

import XCTest
@testable import Social_Mediafy

final class TweetCreationViewModelTests: XCTestCase {
    var sut: CreationViewModelProtocol!
    var api: CreationAPIProtocol!
    var fakeSession: FakeSession!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        fakeSession = FakeSession()
        api = PostCreationAPI(session: fakeSession)
        sut = TweetCreationViewModel(id: "", provider: api)
    }
    
    override func tearDownWithError() throws {
        fakeSession = nil
        api = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func testInitialState() {
        XCTAssertEqual(sut.navTitle, "Create tweet")
        XCTAssertEqual(sut.title, "What's on your mind?")
    }
    
    func testSendTweetLoadingState() {
        // When
        sut.sendData(text: "text")
        
        // Then
        XCTAssertEqual(sut.state.value, .loading)
    }
    
    func testSendTweetSuccessLoadingState() throws {
        // Given
        fakeSession.data = Data()
        var changeState: Bool = false
        let expectation = expectation(description: "Send tweet creation")
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
        sut.sendData(text: "text")
        
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(changeState)
    }
    
    func testSendTweetFailureLoadingState() throws {
        // Given
        fakeSession.error = TweetAPIError.response
        var changeState: Bool = false
        let expectation = expectation(description: "Send tweet creation")
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
        sut.sendData(text: "text")
        
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(changeState)
    }
}
