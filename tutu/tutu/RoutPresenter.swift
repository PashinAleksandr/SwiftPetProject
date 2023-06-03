//
//  RoutPresenter.swift
//  tutu
//
//  Created by Aleksandr Pashin on 12.10.2021.
//

import Foundation

class RoutePresenter: RouteViewOutput {
    weak var view: RouteViewInput!
    var service: RouteService = RouteService.shared
    
    init(view: RouteViewInput) {
        self.view = view
    }
    
    func getRoute() -> [Route] {
        let routes = service.routes
        return routes
    }
    
    func deleteRoute(_ index: Int)  {
        do {
        try? service.deliteRoute(index)
        updateViewState()
        view.updateTable()
        } catch {
            view.show(error)
        }
    }
    
    func deleteAllRoute() {
        do {
            try service.deliteAllRoute()
            updateViewState()
            view.updateTable()
        } catch {
            view.show(error)
        }
    }
    
    func viewWillAppear() {
        updateViewState()
        view.updateTable()
    }
    
    func updateViewState() {
        if service.routes.isEmpty {
            view.switchTo(state: .emptyRouteSheet)
            return
        }
        view.switchTo(state: .defolte)
    }
}
