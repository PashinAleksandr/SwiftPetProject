//
//  EditRoutePresenter.swift
//  tutu
//
//  Created by Aleksandr Pashin on 12.10.2021.
//

import UIKit

class EditRoutePresenter: EditRouteViewOutput {
    var service: RouteService = RouteService.shared
    var view: EditRouteViewImput!
    init (view: EditRouteViewImput) {
        self.view = view
    }
    
    func edit(_ route: Route, index: Int) {
        do {
            try route.validation()
            try service.changeRoute(route: route, index: index)
        } catch {
            view.show(error)
        }
    }
}
