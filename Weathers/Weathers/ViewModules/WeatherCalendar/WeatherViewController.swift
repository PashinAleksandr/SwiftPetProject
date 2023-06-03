//
//  WeatherViewController.swift
//  Weathers
//
//  Created by Aleksandr Pashin on 30.01.2022.
//

import UIKit
import Alamofire

class WeatherCalendarViewController: UIViewController, WeatherCalendarViewInput {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
    var output: WeatherCalendarViewOutput!
    var indexPath: Int = 0
    var sortWeatherArrey: WeatherForSort?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        output = WeatherCalendarPresenter(view: self)
        output.viewIsReady()
        ActivityIndicator.hidesWhenStopped = true
        
    }
    
    func changeSettingsLocation() {
        let openSettings = UIApplication.openSettingsURLString
        if let url = URL(string: openSettings) {
            UIApplication.shared.open(url)
        }
    }
    
    func setupInitialState() {
        let nib = UINib(nibName: "WeatherCalendarTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "WeatherCalendarTableViewCell")
        tableView.rowHeight = 50
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func reload(weatherArray: WeatherForSort) {
        self.sortWeatherArrey = weatherArray
        tableView.reloadData()
    }
}

extension WeatherCalendarViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sortWeatherArrey?.sectionCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionNema = sortWeatherArrey?.getNameSection(section: section)
        return sectionNema
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortWeatherArrey?.rowsNumber(for: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCalendarTableViewCell") as? WeatherCalendarTableViewCell else {
            return UITableViewCell()
        }
        if let weather = sortWeatherArrey?.getWeather(by: indexPath) {
            cell.fill(weather: weather)
        }
        return cell
    }
    
    func startLoading() {
        ActivityIndicator.startAnimating()
        tableView.isHidden = true
    }
    
    func stopLoading() {
        ActivityIndicator.stopAnimating()
        tableView.isHidden = false
    }
    
}
