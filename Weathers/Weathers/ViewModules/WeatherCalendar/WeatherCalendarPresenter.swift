//
//  WeatherCalendarPresenter.swift
//  Weathers
//
//  Created by Aleksandr Pashin on 30.01.2022.
//
import Foundation
import CoreLocation

class WeatherCalendarPresenter: WeatherCalendarViewOutput, LocationServiceObserver {

    var weatherService: WeatherService = WeatherService.shared
    weak var view: WeatherCalendarViewInput!
    var locationService: LocationService = LocationService.share
    
    init(view: WeatherCalendarViewInput) {
        self.view = view
        locationService.register(observer: self)
    }
    
    deinit {
        locationService.remove(observer: self)
    }
    
    func failWeathError(error: Error) {
        view.show(error)
    }
    
    func didChangeLocation(location: CLLocation) {
        loadWeather(by: location)
    }
    
    func goToSettings() {
        view.showAlert(title: "Измените настройки", massege: "Дайте доступ к геолокации")
        view.changeSettingsLocation()
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func loadWeather(by location: CLLocation) {
        view.startLoading()
        weatherService.getWeatherOnFiveDay(lat: location.coordinate.latitude, lon: location.coordinate.longitude) { [weak self] error, weather in
            if let error = error {
                self?.view.show(error)
            }

            if let weather = weather {
                self?.view.stopLoading()
                let newType = WeatherForSort(weatherArray: weather)
                self?.view.reload(weatherArray: newType)
            }
            self?.view.stopLoading()
        }
    }
}

