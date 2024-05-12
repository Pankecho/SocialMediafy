//
//  FakeSession.swift
//  Social MediafyTests
//
//  Created by Juan Pablo Martinez Ruiz on 12/05/24.
//

import Foundation

final class FakeSession: URLSession {
    var data: Data?
    var error: Error?

    override func dataTask(with request: URLRequest,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        MockDataTask {
            completionHandler(self.data, nil, self.error)
        }
    }
}
