//
//  DayViewIO.swift
//  Weathers
//
//  Created by Aleksandr Pashin on 28.01.2022.
//
import Foundation

protocol DayViewInput: AnyObject, UIViewInput {
    func fill(weather: Weather)
    func changeSettingsLocation()
    func startLoading()
    func stopLoading()
}

protocol DayViewOutput {
    func viewIsReady()
}
