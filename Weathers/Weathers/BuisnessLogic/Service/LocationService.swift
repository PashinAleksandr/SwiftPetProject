//
//  LocationService.swift
//  Weathers
//
//  Created by Aleksandr Pashin on 28.01.2022.
//
import Foundation
import CoreLocation

protocol LocationServiceObserver: AnyObject {
    func didChangeLocation(location: CLLocation)
    func failWeathError(error: Error)
    func goToSettings()
}

class WeakBox {
    weak var object: LocationServiceObserver?
    
    init(object: LocationServiceObserver) {
        self.object = object
    }
}

class LocationService: NSObject {
    static var share: LocationService = LocationService()
    var locationManager: CLLocationManager = CLLocationManager()

    private var observers: [WeakBox] = []
    
    private override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func register(observer: LocationServiceObserver) {
        let contains = observers.contains { weakbox in
            observer === weakbox.object
        }
        if !contains {
            let tmp: WeakBox = WeakBox(object: observer)
            observers.append(tmp)
            if let location = locationManager.location {
                observer.didChangeLocation(location: location)
            }
        }
    }
    
    func remove(observer: LocationServiceObserver) {
        observers.removeAll { weakBox in
            weakBox.object === observer
        }
    }
}

extension LocationService: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.distanceFilter = 100
        case .denied, .restricted:
            for index in 0 ..< observers.count {
                observers[index].object?.goToSettings()
            }
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()

        @unknown default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        for index in 0 ..< observers.count {
            observers[index].object?.failWeathError(error: error)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        for index in 0 ..< observers.count {
            observers[index].object?.didChangeLocation(location: location)
        }
    }
}
