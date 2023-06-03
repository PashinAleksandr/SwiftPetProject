//
//  WeatherCalendarTableViewCell.swift
//  Weathers
//
//  Created by Aleksandr Pashin on 02.02.2022.
//

import UIKit

class WeatherCalendarTableViewCell: UITableViewCell {
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cellIconUrl: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("H:mm")
        return df
    }()
    
    func fill(weather: Weather) {
        temperatureLabel.text = Int(weather.temperature).description + " C°"
        timeLabel.text = dateFormatter.string(from: weather.date)
        cellIconUrl.kf.setImage(with: weather.iconURL)
    }
}
