//
//  Double+kelvToCelc.swift
//  Weathers
//
//  Created by Aleksandr Pashin on 07.02.2022.
//

import Foundation

extension Double {
    var kelvToCelc: Double {
        return self - 273.15
    }
    
    
    mutating func convertKelvToCelc() -> Double {
        self = self - 273.15
        return self
    }
}
