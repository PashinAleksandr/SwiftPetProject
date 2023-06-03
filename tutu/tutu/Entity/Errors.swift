//
//  Errors.swift
//  tutu
//
//  Created by Aleksandr Pashin on 27.10.2021.
//

import Foundation

enum ValidationErrors: LocalizedError {
    case emptyDepartureDate
    case emptyDeparturePoint
    case emptyDastenation
    
    var errorDescription: String? {
        switch self {
        case.emptyDepartureDate:
            return "Выберите дату поездки"
        case .emptyDeparturePoint:
            return "Выберите пункт отправления"
        case .emptyDastenation:
            return "Выберите пункт назначения"
        }
    }
    
}

enum SystemError: LocalizedError {
    case `default`
    
    var errorDescription: String? {
        return "Try again later"
    }
}
