//
//  CreatRouteViewIO.swift
//  tutu
//
//  Created by Aleksandr Pashin on 12.10.2021.
//

import Foundation

protocol CreateRouteViewInput: AnyObject, UIViewInput {
    func defaultValue()
}

protocol CreateRouteViewOutput {
    func save(_ route: Route)
}
