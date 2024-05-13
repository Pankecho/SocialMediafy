//
//  ViewControllerFactory.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 13/05/24.
//

import Foundation
import UIKit

protocol ViewControllerFactory {
    func feedViewController() -> UIViewController
    func detailViewController(id: String) -> UIViewController
}
