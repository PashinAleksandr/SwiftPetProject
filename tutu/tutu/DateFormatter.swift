//
//  DateFormatter.swift
//  tutu
//
//  Created by Aleksandr Pashin on 01.11.2021.
//

import Foundation

extension DateFormatter {
    static let myDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("d MMMM yyyy")
        return df
    }()
}
