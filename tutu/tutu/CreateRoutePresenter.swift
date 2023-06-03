//
//  CreatRoutePresenter.swift
//  tutu
//
//  Created by Aleksandr Pashin on 12.10.2021.
//

import UIKit

class CreateRoutePresenter: CreateRouteViewOutput {
    var service: RouteService = RouteService.shared
    weak var view: CreateRouteViewInput!
    
    init (view: CreateRouteViewInput) {
        self.view = view
    }
    
    func save(_ route: Route) { 
        do {
            try route.validation()
            try service.save(route)
            view.showAlert(title: "УВЕДОМЛЕНИЕ!", massege: "Маршрут создан")
            view.defaultValue()
        } catch {
            view.show(error)
        }
    }
}
