//
//  Double+round.swift
//  CriptoWallet
//
//  Created by Aleksandr Pashin on 01.06.2022.
//

import Foundation

extension Double {
    func rounding(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return Foundation.round((self * multiplier) / multiplier)
    }
}
