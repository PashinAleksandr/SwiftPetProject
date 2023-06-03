//
//  RouteTableViewCell.swift
//  tutu
//
//  Created by Aleksandr Pashin on 16.10.2021.
//

import UIKit

class RouteTableViewCell: UITableViewCell {
    @IBOutlet weak var destination: UILabel!
    @IBOutlet weak var date: UILabel!
    
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("d.MM.YY")
        return df
    }()
    
    func fill(route: Route, index: Int) {
        destination.text = route.dastenation + " - " + route.departurePoint
        date.text = dateFormatter.string(from: route.departureDate)
    }
}
