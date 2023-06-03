//
//  DayViewController.swift
//  Weathers
//
//  Created by Aleksandr Pashin on 28.01.2022.
//
import UIKit
import Kingfisher

class DayViewController: UIViewController, DayViewInput {

    var output: DayViewOutput!
    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var pressureImfgeView: UIImageView!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var visibilityImageView: UIImageView!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var windImageView: UIImageView!
    @IBOutlet weak var dewPointImageView: UIImageView!
    @IBOutlet weak var dewPointLabel: UILabel!
    @IBOutlet weak var cloudsLabel: UILabel!
    @IBOutlet weak var moonPhaseImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output = DayPresenter(view: self)
        output.viewIsReady()
        
        activityIndicator.hidesWhenStopped = true
    }
    
    func fill(weather: Weather) {
        cityLabel.text = weather.city
        temperatureLabel.text = Int(weather.temperature).description + " C°"
        pressureLabel.text = weather.pressure.description
        visibilityLabel.text = weather.visibility
        windLabel.text = weather.wind.description
        dewPointLabel.text = weather.dewPoint.description
        cloudsLabel.text = weather.clouds.description
        weatherImageView.kf.setImage(with: weather.iconURL)
    }
    
    func changeSettingsLocation() {
        let openSettings = UIApplication.openSettingsURLString
        if let url = URL(string: openSettings) {
            UIApplication.shared.open(url)
        }
    }
    
    func startLoading() {
        activityIndicator.startAnimating()
        cityLabel.isHidden = true
        temperatureLabel.isHidden = true
        weatherImageView.isHidden = true
        boxView.isHidden = true
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
        cityLabel.isHidden = false
        temperatureLabel.isHidden = false
        weatherImageView.isHidden = false
        boxView.isHidden = false
    }
}
