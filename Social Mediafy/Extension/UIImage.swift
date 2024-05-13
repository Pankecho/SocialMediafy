//
//  UIImage.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 13/05/24.
//

import UIKit

extension UIImage {
    enum Identifier: String {
        case user = "person.circle.fill"
        case comment = "message.circle.fill"
        case fav = "hand.thumbsup.circle.fill"
    }
    
    convenience init(_ identifier: Identifier) {
        self.init(systemName: identifier.rawValue)!
    }
    
}


