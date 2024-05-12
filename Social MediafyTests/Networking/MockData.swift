//
//  MockData.swift
//  Social MediafyTests
//
//  Created by Juan Pablo Martinez Ruiz on 12/05/24.
//

import Foundation

final class MockDataTask: URLSessionDataTask {
    private let closure: () -> ()

    init(closure: @escaping () -> ()) {
        self.closure = closure
    }

    override func resume() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            self.closure()
        }
    }
}
