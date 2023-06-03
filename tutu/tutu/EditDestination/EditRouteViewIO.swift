//
//  EditRouteViewIO.swift
//  tutu
//
//  Created by Aleksandr Pashin on 12.10.2021.
//

import Foundation

protocol EditRouteViewImput: AnyObject, UIViewInput {
    func defolteValue()
}
protocol EditRouteViewOutput {
    func edit(_ route: Route, index: Int)
}
