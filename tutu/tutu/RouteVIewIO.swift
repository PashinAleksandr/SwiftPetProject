//
//  RouteVIewIO.swift
//  tutu
//
//  Created by Aleksandr Pashin on 12.10.2021.
//

import Foundation

protocol RouteViewInput: AnyObject, UIViewInput {
    func updateTable()
    func switchTo(state: RouteViewController.ViewState)
}

protocol RouteViewOutput {
    func getRoute() -> [Route]
    func deleteRoute(_ index: Int)
    func viewWillAppear()
    func deleteAllRoute()
    func updateViewState()
}
