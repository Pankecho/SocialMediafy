//
//  User.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 09/05/24.
//

import Foundation

protocol UserProtocol {
    var id: String { get set }
    var name: String { get set }
    var nickname: String { get set }
}

struct User: UserProtocol, Codable {
    var id: String
    var name: String
    var nickname: String
}
