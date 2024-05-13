//
//  Coordinator.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 13/05/24.
//

import Foundation
import UIKit

protocol Coordinator {
    var rootViewController: UINavigationController { get set }
    func start()
    func pushDetailViewController(id: String)
}
