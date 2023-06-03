//
//  Service.swift
//  tutu
//
//  Created by Aleksandr Pashin on 15.10.2021.
//

import UIKit
import CoreData

protocol RouteServiceProtocol {
    var routes: [Route] { get }
    func deliteRoute(_ index: Int) throws
    func deliteAllRoute() throws
    func save(_ route: Route) throws
    func changeRoute(route:Route, index: Int) throws
}


class RouteService: RouteServiceProtocol {
    var routes: [Route] = []
    var routesEntity: [RouteEntity] = []
    
    static var shared: RouteService = RouteService()
    
    private init() {
    }
    
    func getContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
    private func fetchProducts() -> [RouteEntity] {
        guard let context = getContext(), let routes = try? context.fetch(RouteEntity.fetchRequest()) else {
            return []
        }
        return routes
    }
    
    func map(routes: [RouteEntity]) -> [Route] {
        var newRoutes: [Route] = []
        for index in 0 ..< routes.count {
            if let date = routes[index].date,
                let departurePoint = routes[index].departurePoint,
                let destination = routes[index].destination,
                let note = routes[index].note {
                let route = Route(dastenation: destination, departurePoint: departurePoint, departureDate: date, note: note)
                newRoutes.append(route)
            }
        }
        return newRoutes
    }
    
    
    func deliteRoute(_ index: Int) throws {
        guard let context = getContext() else {
            throw SystemError.default
        }
        routes.remove(at: index)
        let route = routesEntity[index]
        context.delete(route)

        try context.save()
    }
    
    func deliteAllRoute() throws {
        guard let context = getContext() else {
            throw SystemError.default
        }
        for index in 0 ..< routesEntity.count {
            let route = routesEntity[index]
            context.delete(route)
        }
        
        try context.save()
        routesEntity.removeAll()
        routes.removeAll()
    }
    
    func save(_ route: Route) throws {
        guard let context = getContext() else {
            throw SystemError.default
        }
        let routeEntity = RouteEntity(context: context)
        routeEntity.note = route.note
        routeEntity.departurePoint = route.departurePoint
        routeEntity.destination = route.dastenation
        routeEntity.date = route.departureDate

        try context.save()

        routes.append(route)
        routesEntity.append(routeEntity)
    }
    
    func changeRoute(route: Route, index: Int) throws {
        routes[index] = route
        
        routesEntity[index].destination = route.dastenation
        routesEntity[index].departurePoint = route.departurePoint
        routesEntity[index].date = route.departureDate
        routesEntity[index].note = route.note
        guard let context = getContext() else {
            throw SystemError.default
        }
        try context.save()
        
    }
}

