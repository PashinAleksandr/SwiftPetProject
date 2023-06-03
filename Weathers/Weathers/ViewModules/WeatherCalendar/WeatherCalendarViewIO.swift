//
//  WeatherCalendarViewIO.swift
//  Weathers
//
//  Created by Aleksandr Pashin on 30.01.2022.
//
import Foundation
protocol WeatherCalendarViewInput: AnyObject, UIViewInput {
    func setupInitialState()
    func reload(weatherArray: WeatherForSort)
    func changeSettingsLocation()
    func startLoading()
    func stopLoading()
}

protocol WeatherCalendarViewOutput {
    func viewIsReady()
}
