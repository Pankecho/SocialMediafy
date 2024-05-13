//
//  UIFont.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 13/05/24.
//

import UIKit

extension UIFont {
    enum TweetCellSize: CGFloat {
        case name = 16
        case username = 13
        case content, actions = 12
    }
    
    static func bold(withSize size: TweetCellSize) -> UIFont? {
        return .boldSystemFont(ofSize: size.rawValue)
    }
    
    static func normal(withSize size: TweetCellSize) -> UIFont? {
        return .systemFont(ofSize: size.rawValue)
    }
}
