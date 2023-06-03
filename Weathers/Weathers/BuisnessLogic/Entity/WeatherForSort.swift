//
//  WeatherForSort.swift
//  Weathers
//
//  Created by Aleksandr Pashin on 13.02.2022.
//

import Foundation

struct WeatherForSort {
    private var sortWeatherArray: [[Weather]] = []
    let calendar = Calendar.current
    
    var sectionCount: Int {
        return sortWeatherArray.count
    }
    
    init(weatherArray: [Weather]) {
        let numbers = weatherArray

        numbers.forEach { number in
            let firstIndex = sortWeatherArray.firstIndex { n in
                let dateComponents = calendar.dateComponents([.month, .day], from: number.date)
                return n.contains { weather in
                    let currntDateComponents = calendar.dateComponents([.month, .day], from: weather.date )
                    return currntDateComponents == dateComponents
                }
            }
        
            if let index = firstIndex {
                self.sortWeatherArray[index].append(number)
            } else {
                self.sortWeatherArray.append([number])
            }
        }
    }
    
    func rowsNumber(for section: Int) -> Int {
        return sortWeatherArray[section].count
    }
    
    func getWeather(by indexPath: IndexPath) -> Weather {
        let section = indexPath.section
        let row = indexPath.row
        return sortWeatherArray[section][row]
    }
    
    func getNameSection(section: Int) -> String {
        let date = sortWeatherArray[section][0].date
        let dateFormatter: DateFormatter = {
         let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate(" MMMM - dd ")
            return df
        }()
        return dateFormatter.string(from: date)
    }
}
