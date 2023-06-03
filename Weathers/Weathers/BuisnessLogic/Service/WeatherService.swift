//
//  WeatherService.swift
//  Weathers
//
//  Created by Aleksandr Pashin on 28.01.2022.
//
import Foundation
import Alamofire

protocol WeatherServiceProtocol: AnyObject {
    func getweather(lat: Double, lon: Double, completionHandler: @escaping (Error?, Weather?) -> Void)
    func getWeatherOnFiveDay(lat: Double, lon: Double, completionHandler: @escaping (Error?, [Weather]?) -> Void)
}

class WeatherService: WeatherServiceProtocol {

    static var shared: WeatherService = WeatherService()
    
    private init () {}
    
    let APIId: String = "a0b0ff8f47238323bb88b4e0efa71355"
    
    func getWeatherOnFiveDay(lat: Double, lon: Double, completionHandler: @escaping (Error?, [Weather]?) -> Void) {
        let params: Parameters = ["lat": lat, "lon": lon, "appid": APIId]
        
        AF.request("https://api.openweathermap.org/data/2.5/forecast", method: .get, parameters: params).response { responce in
            var array: [Weather] = []
            do {
                guard let data = responce.data,
                      let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let list = json["list"] as? [[String: Any]] else {
                    throw ValidationErrors.cantMap
                }
                try list.forEach { argument in
                    let n: Weather = try Weather(json: argument)
                    array.append(n)
                }
                completionHandler(nil, array)
            } catch {
                completionHandler(error, nil)
            }
        }
    }
    
    func getweather(lat: Double, lon: Double, completionHandler: @escaping (Error?, Weather?) -> Void) {
        let params: Parameters = ["lat": lat, "lon": lon, "appid": APIId]
        
        AF.request("https://api.openweathermap.org/data/2.5/weather", method: .get, parameters: params).response { responce in
            do {
                guard let data = responce.data,
                      let json = try JSONSerialization.jsonObject(with: data) as? [String : Any] else {
                          throw ValidationErrors.cantMap
                      }
                let weather = try Weather(json: json)
                completionHandler(nil, weather)
            } catch {
                completionHandler(error, nil)
            }
        }
    }
}
