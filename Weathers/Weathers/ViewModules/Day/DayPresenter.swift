//
//  DayPresenter.swift
//  Weathers
//
//  Created by Aleksandr Pashin on 28.01.2022.
//
import CoreLocation
import Foundation
import UIKit

class DayPresenter: NSObject, DayViewOutput {
    
    weak var view: DayViewInput!
    
    var weatherService: WeatherServiceProtocol = WeatherService.shared
    var locationService: LocationService = LocationService.share
    
    init(view: DayViewInput) {
        self.view = view
        super.init()
        locationService.register(observer: self)
    }
    
    deinit {
        locationService.remove(observer: self)
    }
    
    func viewIsReady() {
    }
    
}

extension DayPresenter: LocationServiceObserver {
    func goToSettings() {
        view.showAlert(title: "Измените настройки", massege: "Дайте доступ к геолокации") {
            self.view.changeSettingsLocation()
        }
    }
    
    func failWeathError(error: Error) {
        view.show(error)
    }
    
    func didChangeLocation(location: CLLocation) {
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        view.startLoading()
        self.weatherService.getweather(lat: lat, lon: lon) { [weak self] error, weather in
            guard let self = self else { return }
            if let error = error {
                self.view.show(error)
            }
            
            if let weather = weather {
                self.view.fill(weather: weather)
            } 
            self.view.stopLoading()
        }
    }
}
