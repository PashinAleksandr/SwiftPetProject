//
//  Weather.swift
//  Weathers
//
//  Created by Aleksandr Pashin on 28.01.2022.
//
import Foundation

struct Weather {
    var temperature: Double
    var wind: Double
    var pressure: Int
    var dewPoint: Int
    var visibility: String
    var clouds: Int
    var city: String?
    var date: Date
    var iconURL: URL?
    
    init(json: [String: Any]) throws {
        guard let main = json["main"] as? [String: Any],
              var temp = main["temp"] as? Double,
              let pressure = main["pressure"] as? Int,
              let humidity = main["humidity"] as? Int,
              let weather = json["weather"] as? [[String: Any]],
              let description = weather.first?["description"] as? String,
              let wind = json["wind"] as? [String: Any],
              let speed = wind["speed"] as? Double,
              let date = json["dt"] as? Double,
              let clouds = json["clouds"] as? [String: Any],
              let cloudsId = clouds["all"] as? Int,
              let icon = weather.first?["icon"] as? String
        else {
            throw ValidationErrors.cantMap
        }
        self.temperature = temp.convertKelvToCelc()
        self.visibility = description
        self.city = json["name"] as? String
        self.wind = speed
        self.pressure = pressure
        self.dewPoint = humidity
        self.date = Date(timeIntervalSince1970: date)
        self.clouds = cloudsId
        self.iconURL = URL(string: "https://openweathermap.org/img/wn/" + icon + ".png")
    }
}
